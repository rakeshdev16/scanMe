import 'package:scan_me_plus/export.dart';

class DeviceConfig {
  static DeviceModel deviceDetails = DeviceModel();

  static Future<void> init() async {
    deviceDetails = await DeviceConfig.getDeviceInfo();
    debugPrint("DeviceDetails = ${deviceDetails.toJson()}");
  }

  static Future<DeviceModel> getDeviceInfo() async {
    DeviceModel deviceDetails = DeviceModel();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        deviceDetails.deviceName = info.model;
        deviceDetails.deviceOS = "Android";
        deviceDetails.deviceOSVersion = info.version.sdkInt.toString();
        deviceDetails.deviceModel = info.model;
        deviceDetails.deviceId = info.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo info = await deviceInfo.iosInfo;
        deviceDetails.deviceName = info.utsname.machine;
        deviceDetails.deviceOS = "iOS";
        deviceDetails.deviceOSVersion = info.systemName;
        deviceDetails.deviceModel = info.utsname.machine;
        deviceDetails.deviceId = info.identifierForVendor;
        // uniq
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return deviceDetails;
  }
}
