import 'package:scan_me_plus/export.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class ScanQRController extends GetxController {
  MobileScannerController? qrController;

  final GlobalKey qrImageKey = GlobalKey(debugLabel: 'QRImage');

  RxString qrResult = ''.obs;
  RxBool callingStarted = false.obs;

  RxBool scanVehicleLoading = false.obs;
  RxBool sendQRFeedbackLoading = false.obs;

  Rx<SearchedVehicleDataModel> scannedVehicleData =
      SearchedVehicleDataModel().obs;

  Rx<StartCallData> startCallData = StartCallData().obs;
  Rx<Uint8List?> capturedImage = Uint8List(0).obs;

  @override
  void onInit() {
    qrController = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        returnImage: true,
        autoStart: !scanVehicleLoading.value);
    super.onInit();
  }

  takeScreenshot() async {
    RenderRepaintBoundary? boundary =
        qrImageKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    var image = await boundary?.toImage();
    var byteData = await image?.toByteData(format: ImageByteFormat.png);
    capturedImage.value = byteData?.buffer.asUint8List();
  }

  Future<void> scanVehicleData(qrString) async {
    try {
      scanVehicleLoading.value = true;
      Map<String, dynamic> scanVehicleRequestBody = {
        'qr': qrString.split('=').last
      };
      var response =
          await PostRequests.scanVehicleDetails(scanVehicleRequestBody);
      if (response != null) {
        if (response.success!) {
          if (response.data != null) {
            scannedVehicleData.value = response.data!;
          }
        } else {
          // Get.back();
          qrResult.value = '';
          scannedVehicleData.value = SearchedVehicleDataModel();
        }
      } else {
        // Get.back();
        qrResult.value = '';
        scannedVehicleData.value = SearchedVehicleDataModel();
      }
    } finally {
      scanVehicleLoading.value = false;
      callingStarted.value = false;
    }
  }

  Future<void> startCall({receiverId, vehicleId}) async {
    debugPrint("Start Call =====> ");
    try {
      callingStarted.value = true;
      Map<String, dynamic> startCallRequestBody = {
        "recieverId": receiverId,
        "vehicleId": vehicleId,
      };
      var response = await PostRequests.startCall(startCallRequestBody);
      if (response != null) {
        if (response.success!) {
          startCallData.value = response.data!;
          Get.toNamed(AppRoutes.routeCalling, arguments: {
            'channel': response.data?.channelName,
            'token': response.data?.token,
            '_id': response.data?.reciever?.id,
            'image': response.data?.reciever?.image,
            'userName': response.data?.reciever?.userId,
            'callBlocked': response.data?.callBlocked ?? false
          });
        } else {
          Get.back();
          qrController?.start();
          qrResult.value = '';
          scannedVehicleData.value = SearchedVehicleDataModel();
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        Get.back();
        qrController?.start();
        qrResult.value = '';
        scannedVehicleData.value = SearchedVehicleDataModel();
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      callingStarted.value = false;
    }
  }

  Future<void> startOutGoingCall(StartCallData callData) async {
    final params = CallKitParams(
      id: uuid.v4(),
      nameCaller: callData.reciever?.userId,
      avatar: callData.reciever?.image,
      handle: '0123456789',
      type: 1,
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      ios: const IOSParams(handleType: 'number'),
    );
    await FlutterCallkitIncoming.startCall(params);
  }

  void sendQRImage({imagePath, reason, feedback}) async {
    try {
      sendQRFeedbackLoading.value = true;
      Map<String, dynamic> imagesData = {'file': imagePath};
      var result = await PostRequests.uploadFile(imagesData);
      if (result != null) {
        if (result.success!) {
          sendQRFeedback(
              image: result.data?.path, reason: reason, feedback: feedback);
        } else {
          AppAlerts.error(message: result.message!);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {}
  }

  Future<void> sendQRFeedback({image, reason, feedback}) async {
    try {
      Map<String, dynamic> sendFeedbackRequestBody = {
        "image": image,
        "reason": reason,
        "feedback": feedback,
      };
      var response = await PostRequests.sendFeedback(sendFeedbackRequestBody);
      if (response != null) {
        if (response.success) {
          Get.offAllNamed(AppRoutes.routeHome);
          AppAlerts.success(message: response.message);
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      sendQRFeedbackLoading.value = false;
    }
  }
}
