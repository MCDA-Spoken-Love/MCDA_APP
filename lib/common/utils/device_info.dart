import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<Map<String, String>> getOs() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    return {"os": 'android', 'release': info.version.release};
  }
  if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    return {"os": 'ios', 'release': info.systemVersion};
  }

  return {"os": 'Unknown', 'release': 'Unknown'};
}
