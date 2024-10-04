import 'package:scan_me_plus/export.dart';

class PermissionHandler {
  static Future<bool> requestCameraPermission() async {
    //  final serviceStatus = await Permission.camera.isGranted;
    //  final status1 = await Permission.camera.request();
    // bool isCameraOn = serviceStatus == ServiceStat us.enabled;
    var status = await Permission.camera.status;
    if (status.isGranted) {
      // print{'Permission Granted');
      return true;
    }
    /*else if (status.isDenied) {
      // print{'Permission denied');
      await Permission.camera.request();
    } */
    else if (status.isPermanentlyDenied) {
      // print{'Permission Permanently Denied');
      CommonAlertDialog.showDialog(
          title: 'allow_permissions'.tr,
          message: 'go_to_settings'.tr,
          positiveText: 'open_settings'.tr,
          positiveBtCallback: () async {
            await openAppSettings();
          });

//      await openAppSettings();
    } else {
      // print{'Permission denied');
      var status = await Permission.camera.request();

      if (status == PermissionStatus.permanentlyDenied) {
        CommonAlertDialog.showDialog(
            title: 'allow_permissions'.tr,
            message: 'go_to_settings'.tr,
            positiveText: 'open_settings'.tr,
            positiveBtCallback: () async {
              await openAppSettings();
            });
      }
    }
    return false;
  }

  static Future<bool> requestLocationPermission() async {
    //  final serviceStatus = await Permission.camera.isGranted;
    //  final status1 = await Permission.camera.request();
    // bool isCameraOn = serviceStatus == ServiceStatus.enabled;

    var status = await Permission.location.status;

    debugPrint("Permission_status = $status");
    if (status.isGranted) {
      // print{'Permission Granted');
      return true;
    }
    /*else if (status.isDenied) {
      // print{'Permission denied');
      await Permission.camera.request();
    } */
    else if (status.isPermanentlyDenied) {
      // print{'Permission Permanently Denied');
      showInstructionsDialog();
    } else {
      debugPrint('Permission denied');
      var status = await Permission.location.request();

      debugPrint('Permission denied request status = $status');
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        showInstructionsDialog();
      }
    }
    return false;
  }
}

void showInstructionsDialog() {
  CommonAlertDialog.showDialog(
      title: 'allow_permissions'.tr,
      message: 'go_to_settings'.tr,
      positiveText: 'open_settings'.tr,
      positiveBtCallback: () async {
        await openAppSettings();
      });
}
