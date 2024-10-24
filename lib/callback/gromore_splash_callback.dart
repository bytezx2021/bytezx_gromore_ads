import 'package:flutter_gromore/callback/gromore_base_callback.dart';
import 'package:flutter_gromore/ext/GromoreVoidCallbackExt.dart';
import 'package:flutter_gromore/types.dart';

/// 开屏广告回调
class GromoreSplashCallback extends GromoreBaseAdCallback {
  /// 加载成功
  final GromoreVoidCallback? onLoadSuccess;

  /// 加载失败
  final GromoreVoidCallback? onLoadFail;

  /// 广告渲染成功
  final GromoreVoidCallback? onRenderSuccess;

  /// 广告渲染失败
  final GromoreVoidCallback? onRenderFail;

  /// 即将展示
  final GromoreVoidCallback? onWillShow;

  /// 广告开始展示
  final GromoreVoidCallback? onShow;

  /// 广告展示失败
  final GromoreVoidCallback? onShowFailed;

  /// 广告被关闭
  final GromoreVoidCallback? onClose;

  /// 广告被点击
  final GromoreVoidCallback? onClick;

  /// 触发开屏广告自动关闭（由于存在异常场景，导致广告无法正常展示，但无相关回调）
  final GromoreVoidCallback? onAutoClose;

  /// 开屏广告结束，这个时候会销毁广告（点击跳过、倒计时结束或渲染错误等 理应隐藏广告 的情况都会触发此回调，建议统一在此回调处理路由跳转等逻辑）
  final GromoreVoidCallback? onAdEnd;

  /// 广告控制器被关闭 （ios）
  final GromoreVoidCallback? splashAdViewControllerDidClose;

  /// 其他控制器被关闭 (ios)
  final GromoreVoidCallback? splashDidCloseOtherController;

  /// 视频播放完成 (ios)
  final GromoreVoidCallback? splashVideoAdDidPlayFinish;

  GromoreSplashCallback({
    this.onLoadSuccess,
    this.onLoadFail,
    this.onRenderSuccess,
    this.onRenderFail,
    this.onWillShow,
    this.onShow,
    this.onShowFailed,
    this.onClose,
    this.onClick,
    this.onAutoClose,
    this.onAdEnd,
    this.splashAdViewControllerDidClose,
    this.splashDidCloseOtherController,
    this.splashVideoAdDidPlayFinish,
  }) : super();

  /// 执行回调
  @override
  void exec(String callbackName, [dynamic arguments]) {
    switch (callbackName) {
      case "onLoadSuccess":
        onLoadSuccess.isNotNull();

      case "onLoadFail":
        onLoadFail.isNotNull();

      case "onRenderSuccess":
        onRenderSuccess.isNotNull();

      case "onRenderFail":
        onRenderFail.isNotNull();

      case "onWillShow":
        onWillShow.isNotNull();

      case "onShow":
        onShow.isNotNull();

      case "onShowFailed":
        onShowFailed.isNotNull();

      case "onClose":
        onClose.isNotNull();

      case "onClick":
        onClick.isNotNull();

      case "onAutoClose":
        onAutoClose.isNotNull();

      case "onAdEnd":
        onAdEnd.isNotNull();

      case "splashAdViewControllerDidClose":
        splashAdViewControllerDidClose.isNotNull();

      case "splashDidCloseOtherController":
        splashDidCloseOtherController.isNotNull();

      case "splashVideoAdDidPlayFinish":
        splashVideoAdDidPlayFinish.isNotNull();
    }
  }
}
