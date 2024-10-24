//
//  FlutterGromoreSplash.swift
//  flutter_gromore
//
//  Created by Anand on 2024/10/23.
//

import BUAdSDK

class FlutterGromoreSplash:NSObject,BUSplashAdDelegate {

    private var eventId: String?
   
    private var result: FlutterResult

    // 自动关闭timer
    private var closeAdTimer: GCDTask?

    // 自动跳过timer
    private var skipAdTimer: GCDTask?
    
    // 结束标识，防止多次调用
    private var ended = false
    
    init(args: [String: Any], result: @escaping FlutterResult) {
        eventId = args["id"] as? String
        self.result = result
        super.init()
        initAd(args: args)
    }

    private var splashAd: BUSplashAd?
        
    func initAd(args: [String: Any]) {
        guard let adUnitId = args["adUnitId"] as? String else {
            print("Error: adUnitId is missing or not a String.")
            return
        }
        let fullScreenAd :Bool = args["fullScreenAd"] as? Bool ?? true
        let logo: String = args["logo"] as? String ?? ""

        let slot = BUAdSlot()
        slot.id = adUnitId
      // 初始化 BUSplashAd
        self.splashAd = BUSplashAd(slot: slot, adSize: CGSize.zero)
        splashAd?.delegate = self

        if !fullScreenAd && !logo.isEmpty {
            splashAd?.mediation?.customBottomView = generateLogoContainer(name: logo)
        }

        // 开始加载广告
        self.splashAd?.loadData()
        closeAdTimer = GCDTool.gcdDelay(6) {
            self.sendEvent("onAutoClose")
            self.splashEnd(false)
        }
    }

    /// 创建 logo 容器
    private func generateLogoContainer(name: String) -> UIView {
        // logo 图片
        let logoImage: UIView = UIImageView(image: UIImage(named: name))
        // 容器
        let screenSize: CGSize = UIScreen.main.bounds.size
        let logoContainerWidth: CGFloat = screenSize.width
        let logoContainerHeight: CGFloat = screenSize.height * 0.15
        let logoContainer: UIView = UIView(frame: CGRect(x: 0, y: 0, width: logoContainerWidth, height: logoContainerHeight))
        logoContainer.backgroundColor = UIColor.white
        // 居中
        logoImage.contentMode = UIView.ContentMode.center
        logoImage.center = logoContainer.center
        // 设置到开屏广告底部
        logoContainer.addSubview(logoImage)
        return logoContainer
    }
    
    private func sendEvent(_ message: String) {
        if let id = eventId {
            AdEventHandler.instance.sendEvent(AdEvent(id: id, name: message))
        }
    }
    
    // 广告结束
    func splashEnd(_ res: Bool) {
        GCDTool.gcdCancel(closeAdTimer)
        GCDTool.gcdCancel(skipAdTimer)
        if (!ended) {
            ended = true
            sendEvent("onAdEnd")
            result(res)
            splashAd?.mediation?.destoryAd()
        }
    }
    
    /******** 开屏广告回调处理 *********/
    // 加载成功
    func splashAdLoadSuccess(_ splashAd: BUSplashAd) {
      sendEvent("onLoadSuccess")
        self.splashAd?.showSplashView(inRootViewController: UIApplication.shared.keyWindow!.rootViewController!)
    }

    // 加载失败
    func splashAdLoadFail(_ splashAd: BUSplashAd, error: BUAdError?) {
         sendEvent("onLoadFail")
         splashEnd(false)
        
    }

    // 广告即将展示
    func splashAdWillShow(_ splashAd: BUSplashAd) {
        sendEvent("onWillShow")
        closeAdTimer = GCDTool.gcdDelay(6) {
            self.sendEvent("onAutoClose")
            self.splashEnd(false)
        }
    }

    // 广告被点击
    func splashAdDidClick(_ splashAd: BUSplashAd) {
        sendEvent("onClick")
        
    }

    // 广告被关闭
    func splashAdDidClose(_ splashAd: BUSplashAd, closeType: BUSplashAdCloseType) {
       sendEvent("onClose")
       self.splashAd?.mediation?.destoryAd()
       splashEnd(false)
    }

    // 广告展示失败
    func splashAdDidShowFailed(_ splashAd: BUSplashAd, error: Error) {
        sendEvent("onShowFailed")
        splashEnd(false)
    }

    // 广告渲染完成
    func splashAdRenderSuccess(_ splashAd: BUSplashAd) {
        sendEvent("onRenderSuccess")
            
    }

    // 广告渲染失败
    func splashAdRenderFail(_ splashAd: BUSplashAd, error: BUAdError?) {
        sendEvent("onRenderFail")
        splashEnd(false)
    }

    // 广告展示
    func splashAdDidShow(_ splashAd: BUSplashAd) {
        sendEvent("onShow")
    }

    // 广告控制器被关闭
    func splashAdViewControllerDidClose(_ splashAd: BUSplashAd) {
         sendEvent("splashAdViewControllerDidClose")
    }

    // 其他控制器被关闭
    func splashDidCloseOtherController(_ splashAd: BUSplashAd, interactionType: BUInteractionType) {
          sendEvent("splashDidCloseOtherController")
    }

    // 视频播放完成
    func splashVideoAdDidPlayFinish(_ splashAd: BUSplashAd, didFailWithError error: Error?) {
        sendEvent("splashVideoAdDidPlayFinish")
    }
}
