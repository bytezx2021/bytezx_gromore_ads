import 'package:flutter_gromore/config/gromore_base_config.dart';

/// 开屏广告配置
class GromoreInitConfig extends GromoreBaseAdConfig {
  final String appId;

  final String? appName;

  /// 是否启用聚合
  final bool? useMediation;

  /// 正常模式  0是正常模式；1是夜间模
  final int? themeStatus;

  /**
   * 多进程增加注释说明：V>=5.1.6.0支持多进程，如需开启可在初始化时设置.supportMultiProcess(true) ，默认false；
   * 注意：开启多进程开关时需要将ADN的多进程也开启，否则广告展示异常，影响收益。
   * CSJ、gdt无需额外设置，KS、baidu、Sigmob、Mintegral需要在清单文件中配置各家ADN激励全屏xxxActivity属性android:multiprocess="true"
   */
  final bool? multiProcess;

  /// 是否授权位置权限 (Android)
  final bool? isCanUseLocation;

  /// 是否授权手机信息权限 (Android)
  final bool? isCanUsePhoneState;

  /// 是否授权wifi state权限 (Android)
  final bool? isCanUseWifiState;

  /// 是否授权写外部存储权限 (Android)
  final bool? isCanUseWriteExternal;

  /// 是否授权Android Id权限 (Android)
  final bool? isCanUseAndroidId;

  /// 是否限制个性化广告
  final bool? isLimitPersonalAds;

  /// 是否开启程序化广告推荐
  final bool? isProgrammaticRecommend;

  /// 是否禁止CAID (IOS)
  final bool? forbiddenCAID;

  GromoreInitConfig({
    required this.appId,
    this.appName,
    this.useMediation,
    this.themeStatus,
    this.multiProcess,
    this.isCanUseLocation,
    this.isCanUsePhoneState,
    this.isCanUseWifiState,
    this.isCanUseWriteExternal,
    this.isCanUseAndroidId,
    this.isLimitPersonalAds,
    this.isProgrammaticRecommend,
    this.forbiddenCAID,
  });

  @override
  Map toJson() {
    Map result = {
      "id": id,
      "appId": appId,
      "appName": appName,
      "useMediation": useMediation,
      "themeStatus": themeStatus,
      "multiProcess": multiProcess,
      "isCanUseLocation": isCanUseLocation,
      "isCanUsePhoneState": isCanUsePhoneState,
      "isCanUseWifiState": isCanUseWifiState,
      "isCanUseWriteExternal": isCanUseWriteExternal,
      "isCanUseAndroidId": isCanUseAndroidId,
      "isLimitPersonalAds": isLimitPersonalAds,
      "isProgrammaticRecommend": isProgrammaticRecommend,
      "forbiddenCAID": forbiddenCAID,
    };
    result.removeWhere((key, value) => value == null);
    return result;
  }
}
