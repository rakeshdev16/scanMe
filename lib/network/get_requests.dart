import 'package:scan_me_plus/export.dart';

class GetRequests {
  GetRequests._();

  static Future<StatesResponseModel?> fetchStateList() async {
    var apiResponse = await RemoteService.simpleGet(ApiUrls.statedAndCityList);
    if (apiResponse != null) {
      return statesResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<LoginResponseModel?> fetchMyProfile() async {
    var apiResponse = await RemoteService.simpleGet(ApiUrls.userProfile);
    if (apiResponse != null) {
      return loginResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<VehiclesBrandResponseModel?> fetchVehiclesBrand(
      {vehicleType}) async {
    var apiResponse = await RemoteService.simpleGet(
        '${ApiUrls.vehicleBrandList}?vehicleType=$vehicleType');
    if (apiResponse != null) {
      return vehiclesBrandResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<MyVehiclesResponseModel?> fetchMyVehiclesList() async {
    var apiResponse = await RemoteService.simpleGet(ApiUrls.myVehicle);
    if (apiResponse != null) {
      return myVehiclesResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<MembershipPlansResponseModel?> fetchMembershipPlanList(String vehicleId) async {
    var apiResponse = await RemoteService.simpleGet(ApiUrls.membershipPlan + vehicleId);
    if (apiResponse != null) {
      return membershipPlansResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<CallHistoryResponseModel?> fetchCallHistoryList(
      {status}) async {
    var apiResponse =
        await RemoteService.simpleGet(ApiUrls.callListHistory + (status ?? ''));
    if (apiResponse != null) {
      return callHistoryResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<CallDetailResponseModel?> callDetail(String callId) async {
    var apiResponse =
        await RemoteService.simpleGet('${ApiUrls.callDetail}/$callId');
    if (apiResponse != null) {
      return callDetailResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<EmergencyAlertResponseModel?> emergencyAlertList() async {
    var apiResponse =
        await RemoteService.simpleGet(ApiUrls.emergencyAlerts);
    if (apiResponse != null) {
      return emergencyAlertResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ShippingAddressResponseModel?> shippingAddressList() async {
    var apiResponse =
        await RemoteService.simpleGet(ApiUrls.shippingAddressList);
    if (apiResponse != null) {
      return shippingAddressResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<NotificationsResponseModel?> notificationList() async {
    var apiResponse =
        await RemoteService.simpleGet(ApiUrls.notificationList);
    if (apiResponse != null) {
      return notificationsResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<AlertNotificationsResponseModel?> alertNotificationList() async {
    var apiResponse =
        await RemoteService.simpleGet(ApiUrls.alertNotificationList);
    if (apiResponse != null) {
      return alertNotificationsResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BlockedUserResponseModel?> blockedUsersList() async {
    var apiResponse =
        await RemoteService.simpleGet(ApiUrls.blockedUsersList);
    if (apiResponse != null) {
      return blockedUserResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<InvoiceDetailResponseModel?> downloadInvoice(String id) async {
    var apiResponse =
    await RemoteService.simpleGet('${ApiUrls.downloadInvoice}$id');
    if (apiResponse != null) {
      return invoiceDetailResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> shippingStatus(String id) async {
    var apiResponse =
    await RemoteService.simpleGet('${ApiUrls.shippingOrderStatus}$id');
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BannerResponseModel?> getBannerList() async {
    var apiResponse =
    await RemoteService.simpleGet(ApiUrls.banner);
    if (apiResponse != null) {
      return bannerResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

}
