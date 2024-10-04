
import 'package:scan_me_plus/export.dart';

class PutRequests{

  PutRequests._();

  static Future<BaseResponseModel?> deleteVehicleTemporarily(
      {required Map<String, dynamic> requestBody, vehicleId}) async {
    var apiResponse =
    await RemoteService.simplePut(endUrl: '${ApiUrls.temporaryDeleteVehicle}$vehicleId',requestBody: requestBody);
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> callStatus(
      {required Map<String, dynamic> requestBody, required callId, required callStatus}) async {
    var apiResponse =
    await RemoteService.simplePut(endUrl: '${ApiUrls.callStatus}/$callId?callStatus=$callStatus',requestBody: requestBody);
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }
}