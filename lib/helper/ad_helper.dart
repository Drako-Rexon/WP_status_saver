import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5438809618033122/5119367254";
    } else {
      throw UnsupportedError('message');
    }
  }
}
