import 'package:scan_me_plus/export.dart';

class ScanQRScreen extends GetView<ScanQRController> {
  ScanQRScreen({super.key});

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        leading: Inkwell(
            onTap: () => Get.back(),
            child: Image.asset(AppImages.iconClose).paddingAll(18.w)),
        widgets: [
          Inkwell(
              onTap: () {
                controller.qrController?.toggleTorch();
              },
              child: Image.asset(AppImages.iconFlashLight).paddingAll(15.w)),
          _qrPopUpMenu(context)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                RepaintBoundary(
                  key: controller.qrImageKey,
                  child: MobileScanner(
                    controller: controller.qrController,
                    onDetect: (capture) {
                      controller.qrController?.stop();
                      final List<Barcode> barcodes = capture.barcodes;
                      controller.scanVehicleData(barcodes.first.url?.url);
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                      Get.find<MainController>().getEmergencyAlertList();
                      _openScannerDetails(context);
                    },
                  ),
                ),
                Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                        color: Colors.black38, width: Get.height * 0.25),
                    bottom: BorderSide(
                        color: Colors.black38, width: Get.height * 0.25),
                    left: BorderSide(
                        color: Colors.black38, width: Get.width * 0.2),
                    right: BorderSide(
                        color: Colors.black38, width: Get.width * 0.2),
                  )),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                )),
            child: Text(
              'scan_to_connect_vehicle_owner'.tr,
              style: Theme.of(context).textTheme.bodySmall,
            ).paddingSymmetric(vertical: 25.h),
          )
        ],
      ),
    );
  }

  _openScannerDetails(context) => CommonBottomSheetBackground.show(
      content: Obx(() => controller.scannedVehicleData.value.sId != null
          ? VehicleDetailBottomSheetContent(
              userName:
                  '@${controller.scannedVehicleData.value.user?.userId ?? ''}',
              userId: controller.scannedVehicleData.value.user?.sId ?? '',
              vehicleId: controller.scannedVehicleData.value.sId ?? '',
              vehicleNumber:
                  controller.scannedVehicleData.value.vehicleNumber ?? '',
              vehicleModel:
                  controller.scannedVehicleData.value.vehicleModel?.name ?? '',
              vehicleImage:
                  controller.scannedVehicleData.value.vehicleModel?.image ?? '',
              vehicleBrand:
                  controller.scannedVehicleData.value.vehicleBrand?.name ?? '',
              vehicleBrandImage:
                  controller.scannedVehicleData.value.vehicleBrand?.image ?? '',
              isBlockEnable: false,
              isCalling: controller.callingStarted,
              onCrossPress: () {
                Get.back();
                controller.qrController?.start();
                controller.qrResult.value = '';
                controller.scannedVehicleData.value =
                    SearchedVehicleDataModel();
              },
              onEmergencyAlertPress: () {
                controller.qrController?.start();
                controller.qrResult.value = '';
                controller.scannedVehicleData.value =
                    SearchedVehicleDataModel();
              },
              onCallStart: () async {
                controller.callingStarted.value = true;
                controller.startCall(
                    receiverId: controller.scannedVehicleData.value.user?.sId,
                    vehicleId: controller.scannedVehicleData.value.sId);
                return controller.callingStarted.value;
              },
            )
          : Container(
              width: Get.width,
              height: Get.height * 0.4,
              alignment: Alignment.center,
              child: controller.scanVehicleLoading.value
                  ? SizedBox(
                      height: 30.h,
                      width: 30.h,
                      child: const CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Inkwell(
                              onTap: () {
                                Get.back();
                                controller.qrController?.start();
                                controller.qrResult.value = '';
                                controller.scannedVehicleData.value =
                                    SearchedVehicleDataModel();
                              },
                              child: Image.asset(
                                AppImages.iconClose,
                                height: 12.h,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppImages.iconInvalidQR,
                                  height: 60.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'Invalid QR',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                          color: AppColors.invalidColor,
                                          fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ]),
            )),
      topMargin: 6.h,
      isDismissible: false);

  _qrPopUpMenu(context) => SizedBox(
        width: 15.h,
        child: PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                height: 35.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                child: Text(
                  "send_qr_feedback".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.colorTextSecondary),
                ).paddingOnly(bottom: 4.h)),
            PopupMenuItem(
                value: 2,
                height: 26.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                child: Text(
                  "get_help".tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.colorTextSecondary),
                ))
          ],
          padding: EdgeInsets.symmetric(vertical: 15.h),
          icon: Image.asset(
            AppImages.iconMore,
            height: 15.h,
            color: Colors.white,
          ),
          position: PopupMenuPosition.under,
          popUpAnimationStyle: AnimationStyle(
              curve: Curves.ease, duration: const Duration(seconds: 1)),
          color: Colors.white,
          elevation: 0,
          onSelected: (value) {
            if (value == 1) {
              _qrNotWorkingBottomSheet(context);
            } else if (value == 2) {}
          },
        ),
      ).paddingOnly(right: 20.w);

  _qrNotWorkingBottomSheet(context) => CommonBottomSheetBackground.show(
      content: Column(
        children: [
          Text(
            'qr_not_working'.tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'send_feedback_to_us'.tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ).paddingOnly(bottom: 18.h),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                text: 'not_now'.tr,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                backgroundColor: Colors.transparent,
                borderColor: AppColors.kPrimaryColor,
                textColor: AppColors.kPrimaryColor,
                onPressed: () {
                  Get.back();
                },
              )),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                  child: CustomButton(
                text: 'send_feedback'.tr,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                onPressed: () async {
                  await controller.takeScreenshot();
                  final directory = await getApplicationCacheDirectory();
                  final path =
                      await File('${directory.path}/scanner_screenShot.png')
                          .create();
                  final Uint8List? bytes =
                      controller.capturedImage.value?.buffer.asUint8List();
                  await path.writeAsBytes(bytes!);
                  Get.back();
                  SendFeedbackBottomSheet.show(image: path.path);
                },
              )),
            ],
          )
        ],
      ),
      topMargin: 8.h,
      isDismissible: false);
}
