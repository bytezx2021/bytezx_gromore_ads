import 'dart:io';

/// APP名称
const APP_NAME = "牛小二招聘";

/// 是否是生产环境
const IS_PRODUCTION = false;

class GroMoreAdConfig {
  /// APP-ID
  static String get appId {
    if (Platform.isAndroid) {
      return '5620602';
    }
    return '5620602';
  }

  /// 开屏广告ID
  static String get splashId {
    if (Platform.isAndroid) {
      return '103196462';
    }
    return '103196462';
  }

  /// 信息流广告ID
  static String get feedId {
    if (Platform.isAndroid) {
      return '102361544';
    }
    return '102391145';
  }

  /// 插屏广告ID
  static String get interstitialId {
    if (Platform.isAndroid) {
      return '103199133';
    }
    return '103199133';
  }

  /// 激励视频广告ID
  static String get rewardId {
    if (Platform.isAndroid) {
      return '103196191';
    }
    return '103196191';
  }

  /// 激励视频广告ID
  static String get bannerId {
    if (Platform.isAndroid) {
      return '103196191';
    }
    return '103196191';
  }
}
