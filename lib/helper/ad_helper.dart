import 'dart:io';

/**
 * app id admob: ca-app-pub-3743670847940592~4048090052
 * ca-app-pub-3743670847940592/1158497989
 */

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3743670847940592/1158497989";
    } else {
      throw UnsupportedError('message');
    }
  }
}
