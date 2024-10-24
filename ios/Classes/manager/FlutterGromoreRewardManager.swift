//
//  FlutterGromoreRewardManager.swift
//  flutter_gromore
//
//  Created by Stahsf on 2023/6/13.
//

import Foundation
import BUAdSDK

class FlutterGromoreRewardManager: NSObject,BUMNativeExpressRewardedVideoAdDelegate {
    private var args: [String: Any]
    private var result: FlutterResult
    private var rewardedVideoAd: BUNativeExpressRewardedVideoAd?

    init(args: [String: Any], result: @escaping FlutterResult) {
        self.args = args
        self.result = result
    }



  /******** 激励广告配置 *********/
  func loadAd() -> Void {
       let adUnitId: String = args["adUnitId"] as! String
      let slot = BUAdSlot()
      slot.id = "961347545"
      slot.mediation.mutedIfCan = false;    // 奖励发放设置
      let rewardedVideoModel = BURewardedVideoModel()

      let rewardedVideoAd = BUNativeExpressRewardedVideoAd(slot: slot, rewardedVideoModel: rewardedVideoModel)
      rewardedVideoAd.delegate = self
      // 如果使用再看一次功能时，需要设置rewardPlayAgainInteractionDelegate，如果要区分是否为再看一次请使用不同的代理对象
      // rewardedVideoAd.rewardPlayAgainInteractionDelegate = self
      // 设置portrait
      rewardedVideoAd.mediation?.addParam(NSNumber(value: 0), withKey: "show_direction")
      self.rewardedVideoAd = rewardedVideoAd
      self.rewardedVideoAd?.loadData()
  }


//
//     func loadAd() {
//         let adUnitId: String = args["adUnitId"] as! String
//
//         let slot = BUAdSlot()
//         slot.mediation.mutedIfCan = args["muted"] as? Bool ?? true
//         slot.id = adUnitId
//
//         let model = BURewardedVideoModel()
//         rewardAd = BURewardedVideoAd.init(slot: slot, rewardedVideoModel: model)
//         if let ad = rewardAd {
//             ad.delegate = self
//             ad.loadData()
//         }
//     }
//
//     // 加载成功
//     func rewardedVideoAdDidLoad(_ rewardedVideoAd: BURewardedVideoAd) {
//         let id = String(rewardedVideoAd.hashValue)
//         FlutterGromoreRewardCache.addAd(key: id, ad: rewardedVideoAd)
//         result(id)
//     }
//
//     // 加载失败
//     func rewardedVideoAd(_ rewardedVideoAd: BURewardedVideoAd, didFailWithError error: Error?) {
//         result(FlutterError(code: "0", message: error?.localizedDescription ?? "", details: error?.localizedDescription ?? ""))
//     }
    
    /******** 激励广告回调处理 *********/
    // MARK: - BUMNativeExpressRewardedVideoAdDelegate
    // 广告加载成功
    func nativeExpressRewardedVideoAdDidLoad(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd) {
        // 广告加载成功之后，可以调用展示方法，按照实际需要调整代码位置
                 let id = String(rewardedVideoAd.hashValue)
                 FlutterGromoreRewardCache.addAd(key: id, ad: rewardedVideoAd)
                 result(id)
    }

    // 广告加载失败
    func nativeExpressRewardedVideoAd(_ rewardedVideoAd: BUNativeExpressRewardedVideoAd, didFailWithError error: Error?) {
        print("激励视频加载失败：")
        print(error)
                 result(FlutterError(code: "0", message: error?.localizedDescription ?? "", details: error?.localizedDescription ?? ""))
        
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
