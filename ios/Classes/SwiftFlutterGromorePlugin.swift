import Flutter
import UIKit
import AppTrackingTransparency
import BUAdSDK
import AdSupport

public class SwiftFlutterGromorePlugin: NSObject, FlutterPlugin {
    private static var messenger: FlutterBinaryMessenger? = nil
    private var splashAd: FlutterGromoreSplash?
    private var interstitialManager: FlutterGromoreInterstitialManager?
    private var rewardManager: FlutterGromoreRewardManager?
    private var interstitialFullAd: FlutterGromoreInterstitial?
    private var rewardAd: FlutterGromoreReward?
    private var initResuleCalled: Bool = false
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: FlutterGromoreContants.methodChannelName, binaryMessenger: registrar.messenger())
        let eventChanel = FlutterEventChannel(name: FlutterGromoreContants.eventChannelName, binaryMessenger: registrar.messenger())
        eventChanel.setStreamHandler(AdEventHandler.instance)
        let instance = SwiftFlutterGromorePlugin()
        
        messenger = registrar.messenger()
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.register(FlutterGromoreFactory(messenger: registrar.messenger()), withId: FlutterGromoreContants.feedViewTypeId)
        registrar.register(FlutterGromoreBannerFactory(messenger: registrar.messenger()), withId: FlutterGromoreContants.bannerTypeId)
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, Any> ?? [:]
        switch call.method {
        case "requestATT":
            requestATT(result: result)
        case "initSDK":
            initSDK(args:args,result: result)
        case "showSplashAd":
            splashAd = FlutterGromoreSplash(args: args, result: result)
        case "loadInterstitialAd":
            interstitialManager = FlutterGromoreInterstitialManager(args: args, result: result)
            interstitialManager?.loadAd()
        case "showInterstitialAd":
            interstitialFullAd = FlutterGromoreInterstitial(messenger: SwiftFlutterGromorePlugin.messenger!, arguments: args, result: result)
        case "removeInterstitialAd":
            removeInterstitialAd(args: args, result: result)
        case "loadFeedAd":
            let feedManager = FlutterGromoreFeedManager(args: args, result: result)
            feedManager.loadAd()
        case "removeFeedAd":
            removeFeedAd(args: args, result: result)
         case "loadRewardAd":
             rewardManager = FlutterGromoreRewardManager(args: args, result: result)
             rewardManager?.loadAd()
         case "showRewardAd":
             rewardAd = FlutterGromoreReward(messenger: SwiftFlutterGromorePlugin.messenger!, arguments: args, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // 请求广告标识符
    private func requestATT(result: @escaping FlutterResult){
        // iOS 14 之后需要获取 ATT 追踪权限
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                let isAuthorized: Bool = status == ATTrackingManager.AuthorizationStatus.authorized
                result(isAuthorized)
            })
        } else {
            result(true)
        }
    }
    
    // 初始化SDK
    private func initSDK(args: [String: Any],result: @escaping FlutterResult) {
        // 已经初始化
        if (BUAdSDKManager.state  == BUAdSDKState.start) {
            result(true)
            return
        }
        let appId = args["appId"] as? String ?? nil
        let useMediation = args["useMediation"] as? Bool ?? false
        let isLimitPersonalAds = args["isLimitPersonalAds"] as? Int ?? 0
        let forbiddenCAID = args["forbiddenCAID"] as? Int ?? 0
        let isProgrammaticRecommend = args["isProgrammaticRecommend"] as? Int ?? 0
        let themeStatus = args["themeStatus"] as? Int ?? 0
        
        if let appId = args["appId"] as? String, appId.isEmpty {
            result(FlutterError(code: "0", message: "appId为空", details: "appId不能为空"))
            return
          }
        
        #if DEBUG
        let isDebug = 1
        #else
        let isDebug = 0
        #endif
       
        
        let configuration = BUAdSDKConfiguration()
        configuration.appID = appId

        configuration.debugLog = NSNumber(integerLiteral: isDebug)
        // 使用聚合
       configuration.useMediation = useMediation
        // 隐私合规配置
        // 是否限制个性化广告
        configuration.mediation.limitPersonalAds = NSNumber(integerLiteral: isLimitPersonalAds)
        // 是否限制程序化广告
        configuration.mediation.limitProgrammaticAds = NSNumber(integerLiteral: isLimitPersonalAds)
        // 是否禁止CAID
        configuration.mediation.forbiddenCAID = NSNumber(integerLiteral:forbiddenCAID)
        // 主题模式
        configuration.themeStatus = NSNumber(integerLiteral: themeStatus)
        
        // 初始化
       BUAdSDKManager.start(asyncCompletionHandler:{ success, error in
           if (self.initResuleCalled) {
               return
           }
           if success {
               self.initResuleCalled = true
               result(true)
           } else {
               self.initResuleCalled = true
               result(FlutterError(code: "0", message: error?.localizedDescription ?? "", details: error?.localizedDescription ?? ""))
           }
       })
    }
    
    /// 移除缓存中信息流广告
    private func removeFeedAd(args: [String: Any], result: @escaping FlutterResult) {
        if let feedId = args["feedId"] as? String {
            FlutterGromoreFeedCache.removeAd(key: feedId)
        }
        result(true)
    }
    
    /// 移除缓存中插屏广告
    private func removeInterstitialAd(args: [String: Any], result: @escaping FlutterResult) {
        if let interstitialId = args["interstitialId"] as? String {
            FlutterGromoreInterstitialCache.removeAd(key: interstitialId)
        }
        result(true)
    }
}
