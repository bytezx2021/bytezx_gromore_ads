
// typedef GromoreVoidCallback = void Function();

// 扩展 GromoreVoidCallback? 类型
import 'package:flutter_gromore/types.dart';

extension GromoreVoidCallbackExtension on GromoreVoidCallback? {
  void isNotNull() {
    if (this != null) {
      this!();
    }
  }
}