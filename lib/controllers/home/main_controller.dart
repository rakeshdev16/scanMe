// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:scan_me_plus/export.dart';

class MainController extends GetxController {
  RxList<Widget> screens = <Widget>[
    const HomeScreen(),
    const CallHistoryScreen(),
    Container(),
    const PurchaseListScreen(),
    const MyProfileScreen(),
  ].obs;

  RxInt selectedTab = 0.obs;
  RxBool alertsLoading = false.obs;
  RxBool sendingAlert = false.obs;
  RxBool isNewNotification = false.obs;

  RxList<EmergencyAlertData> emergencyAlerts = <EmergencyAlertData>[].obs;

  @override
  void onInit() {
    getProfile();
    getNewNotificationStatus();
    updateFcmToken();
    socket = SocketHelper.getInstance();
    if (Get.arguments != null) {
      selectedTab.value = Get.arguments['selected_tab'];
    }
    // if(Platform.isAndroid){
    //   overlayPermissionRequest();
    // }
    super.onInit();
  }

  overlayPermissionRequest() async {
    final status = await Permission.systemAlertWindow.isGranted;
    if (!status) {
      await Permission.systemAlertWindow.request();
    }
  }

  getProfile() async {
    try {
      var result = await GetRequests.fetchMyProfile();
      if (result != null) {
        if (result.success!) {
          PreferenceManager.user = result.data;
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      }
    } finally {}
  }

  void updateFcmToken() async {
    if (Platform.isIOS) {
      var apns = await FirebaseMessaging.instance.getAPNSToken();
      debugPrint('apns $apns ');
      // if (apns != null) {
      //   try {
      //     debugPrint('ApnsToken ------->  $apns');
      //     Map<String, dynamic> requestBody = {'fcmToken': apns};
      //     PostRequests.updateFCMToken(requestBody);
      //   } on Exception catch (e) {
      //     debugPrint("Error facing while updating Fcm token --->>>> $e");
      //   }
      // }
    }
    // else{
      String? fcmToken = await NotificationService().getFcmToken();
      if (fcmToken != null) {
        try {
          debugPrint('FcmToken ------->  $fcmToken');
          Map<String, dynamic> requestBody = {'fcmToken': fcmToken};
          PostRequests.updateFCMToken(requestBody);
        } on Exception catch (e) {
          debugPrint("Error facing while updating Fcm token --->>>> $e");
        }
      }
    // }
  }

  getEmergencyAlertList() async {
    try {
      alertsLoading.value = true;
      var result = await GetRequests.emergencyAlertList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            emergencyAlerts.value = result.data!;
            emergencyAlerts.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      alertsLoading.value = false;
    }
  }

  Future<void> sendEmergencyAlerts(context,
      {userId, vehicleId, emergencyAlert}) async {
    try {
      sendingAlert.value = true;
      Map<String, dynamic> sendAlertRequestBody = {
        "alertUser": userId,
        "emergencyAlert": emergencyAlert,
        "vehicle": vehicleId
      };
      var response =
          await PostRequests.sendEmergencyAlerts(sendAlertRequestBody);
      if (response != null) {
        if (response.success) {
          Get.back();
          _alertSentSuccessful(context);
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      sendingAlert.value = false;
    }
  }

  _alertSentSuccessful(context) => CommonBottomSheetBackground.show(
      content: MessageBottomSheetContent(
        icon: AppImages.iconEmergencyAlert,
        messageText: 'emergency_alert_sent'.tr,
        buttonText: 'ok'.tr,
        onButtonPress: () {
          Get.back();
          if (Get.isRegistered<ScanQRController>()) {
            Get.find<ScanQRController>().qrController?.start();
            Get.find<ScanQRController>().qrResult.value = '';
            Get.find<ScanQRController>().scannedVehicleData.value =
                SearchedVehicleDataModel();
          }
        },
      ),
      isDismissible: false);

  getNewNotificationStatus() async {
    try {
      var result = await PostRequests.newNotification();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            isNewNotification.value = result.data!;
          }
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {}
  }
}
