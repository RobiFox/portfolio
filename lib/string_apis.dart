import 'package:flutter/foundation.dart';

extension AssetString on String {
  String asAsset() {
    return "${(kDebugMode && kIsWeb)?"":"assets/"}/${this}";
  }
}