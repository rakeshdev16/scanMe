import 'package:scan_me_plus/export.dart';

class PostRequests {
  PostRequests._();

  static Future<bool> checkMobileNumberExist(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.checkMobileNumber);
    if (apiResponse != null) {
      var response = checkMailExistsResModelFromJson(apiResponse.response!);
      return response.success;
    } else {
      return true;
    }
  }

  static Future<RequestOtpResModel?> requestOtp(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.requestOtp);
    if (apiResponse != null) {
      return requestOtpResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<bool> checkEmailExist(String email) async {
    var requestBody = {'email': email};
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.checkEmail);
    if (apiResponse != null) {
      var response = checkMailExistsResModelFromJson(apiResponse.response!);
      return response.success;
    } else {
      return true;
    }
  }

  static Future<bool> checkUserIdExist(String userId) async {
    var requestBody = {'userId': userId};
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.checkUserId);
    if (apiResponse != null) {
      var response = checkMailExistsResModelFromJson(apiResponse.response!);
      return response.success;
    } else {
      return true;
    }
  }

/*  static Future<LoginResponseModel?> registerUser(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.registerUser);

    if (apiResponse != null) {
      return loginResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }*/

  static Future<LoginResponseModel?> loginUser(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.loginUser);

    if (apiResponse != null) {
      return loginResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<LoginResponseModel?> registerUser(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.updateUserProfile);

    if (apiResponse != null) {
      return loginResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<LoginResponseModel?> updateUser(
    Map<String, String> requestBody,
  ) async {
    var apiResponse = await RemoteService.simplePost(
      requestBody,
      ApiUrls.updateUserProfile,
    );
    if (apiResponse != null) {
      return loginResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<UploadFileResponseModel?> uploadFile(
    Map<String, dynamic> imagesData,
  ) async {
    var apiResponse = await RemoteService.uploadPhotos(
        endUrl: ApiUrls.uploadFile, imagesData: imagesData);
    if (apiResponse != null) {
      return uploadFileResModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<AddVehicleResponseModel?> addVehicle(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.addVehicle);

    if (apiResponse != null) {
      return addVehiclesResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<SearchedVehicleResponseModel?> searchVehicle(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.vehicleSearch);

    if (apiResponse != null) {
      return searchedVehiclesResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<SearchedVehicleResponseModel?> scanVehicleDetails(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.scanVehicle);

    if (apiResponse != null) {
      return searchedVehiclesResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<SubscriptionPaymentLinkResponseModel?> subscriptionPlanPurchase(
      Map<String, dynamic> requestBody) async {
    var apiResponse = await RemoteService.simplePost(
        requestBody, ApiUrls.subscribeMemberShipPlan);

    if (apiResponse != null) {
      return subscriptionLinkResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> paymentSuccessful(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.paymentSuccessful);

    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> updateFCMToken(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.updateFcm);

    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<StartCallResponseModel?> startCall(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
        await RemoteService.simplePost(requestBody, ApiUrls.startCall);

    if (apiResponse != null) {
      return startCallResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> blockUnblockUser({userId,blockStatus}) async {
    var apiResponse = await RemoteService.simplePost(
        {}, '${ApiUrls.blockUnblockUser}/$userId?blockStatus=$blockStatus');
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> sendEmergencyAlerts(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.sendAlerts);

    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<AddShippingAddressResponseModel?> addShippingAddress(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.addShippingAddress);

    if (apiResponse != null) {
      return addShippingAddressResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<ReplacementRequestResponseModel?> replacementRequest(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.replacementRequest);

    if (apiResponse != null) {
      return replacementRequestResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> sendFeedback(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.scanFeedback);

    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> helpSupport(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.helpSupport);
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> shippingOrder(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.shippingOrder);
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<BaseResponseModel?> cancelSubscriptionPlan(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.cancelSubscription);
    if (apiResponse != null) {
      return baseResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<UpgradeSubscriptionResponseModel?> upgradeSubscriptionPlan(
      Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.upgradeSubscription);
    if (apiResponse != null) {
      return upgradeSubscriptionResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<NewNotificationStatusResponseModel?> newNotification() async {
    var apiResponse =
    await RemoteService.simplePost({}, ApiUrls.newNotification);
    if (apiResponse != null) {
      return newNotificationStatusResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }

  static Future<StaticPagesResponseModel?> staticPages( Map<String, dynamic> requestBody) async {
    var apiResponse =
    await RemoteService.simplePost(requestBody, ApiUrls.staticPages);
    if (apiResponse != null) {
      return staticPagesResponseModelFromJson(apiResponse.response!);
    } else {
      return null;
    }
  }
}
