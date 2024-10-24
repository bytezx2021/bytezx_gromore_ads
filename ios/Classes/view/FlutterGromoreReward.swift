//
//  FlutterGromoreReward.swift
//  flutter_gromore
//
//  Created by Stahsf on 2023/6/13.
//

import Foundation
import BUAdSDK

class FlutterGromoreReward: NSObject,FlutterGromoreBase,BUMNativeExpressRewardedVideoAdDelegate {
    var methodChannel: FlutterMethodChannel?
    private var args: [String: Any]
    private var rewardAd: BUNativeExpressRewardedVideoAd?
    private var result: FlutterResult
    private var rewardId: String = ""
    
    init(messenger: FlutterBinaryMessenger, arguments: [String: Any], result: @escaping FlutterResult) {
        args = arguments
        self.result = result
        super.init()
        rewardId = arguments["rewardId"] as! String
        rewardAd = FlutterGromoreRewardCache.getAd(key: rewardId)
        methodChannel = initMethodChannel(channelName: "\(FlutterGromoreContants.rewardTypeId)/\(rewardId)", messenger: messenger)
        initAd()
        
       
    }
    
    func initAd() {
        if let ad = rewardAd, ad.mediation?.isReady ?? false {
            ad.delegate = self
            ad.show(fromRootViewController: Utils.getVC())
        }
    }
    
    func destroyAd() {
        FlutterGromoreRewardCache.removeAd(key: rewardId)
        rewardAd = nil
    }
    
    // 广告素材加载完成
    func nativeExpressRewardedVideoAdDidDownLoadVideo(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {

    }

    // 广告展示失败
    func nativeExpressRewardedVideoAdDidShowFailed(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, error: Error) {
        
    }

    // 广告已经展示
    func nativeExpressRewardedVideoAdDidVisible(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        /*
        //  (注意: getShowEcpmInfo 需要在当前广告展示之后调用, 展示之前调用该方法会返回 nil)
        let info = rewardedVideoAd.mediation?.getShowEcpmInfo()
        print("ecpm:\(info?.ecpm ?? "None")")
        print("platform:\(info?.adnName ?? "None")")
        print("ritID:\(info?.slotID ?? "None")")
        print("requestID:\(info?.requestID ?? "None")")
        */
    }

    // 广告已经关闭
    func nativeExpressRewardedVideoAdDidClose(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        
    }

    // 广告被点击
    func nativeExpressRewardedVideoAdDidClick(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        
    }

    // 广告被点击跳过
    func nativeExpressRewardedVideoAdDidClickSkip(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
            
    }

    // 广告视频播放完成
    func nativeExpressRewardedVideoAdDidPlayFinish(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, didFailWithError error: Error?) {
        
    }

    // 广告奖励下发
    func nativeExpressRewardedVideoAdServerRewardDidSucceed(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, verify: Bool) {
        if verify {
            // 验证通过
            // 从rewardedVideoAd.rewardedVideoModel读取奖励信息
        } else {
            // 未验证通过
        }
    }

    // 广告奖励下发失败
    func nativeExpressRewardedVideoAdServerRewardDidFail(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, error: Error?) {

    }

}
