import 'package:scan_me_plus/export.dart';

class DeleteRequests {
  DeleteRequests._();

  static Future<BaseResponseModel?> deleteVehiclePermanently(
      String vehicleId) async {
    var apiResponse = await RemoteService.simpleDelete(
        '${ApiUrls.permanentDeleteVehicle}$vehicleId');
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> deleteCall(String callId) async {
    var apiResponse =
        await RemoteService.simpleDelete('${ApiUrls.deleteCall}$callId');
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> deleteAlertNotification(String notificationId) async {
    var apiResponse =
        await RemoteService.simpleDelete('${ApiUrls.deleteAlertNotification}$notificationId');
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> deleteNotification(String notificationId) async {
    var apiResponse =
        await RemoteService.simpleDelete('${ApiUrls.deleteNotification}$notificationId');
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> deleteAccount() async {
    var apiResponse =
        await RemoteService.simpleDelete('${ApiUrls.delteAccount}${PreferenceManager.user?.sId}');
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }
}
