import 'package:scan_me_plus/export.dart';

class ConfirmVehicleDetailsController extends GetxController {
  TextEditingController brandTextController = TextEditingController();
  FocusNode brandFocusNode = FocusNode();
  TextEditingController modelTextController = TextEditingController();
  FocusNode modelFocusNode = FocusNode();
  TextEditingController vehicleNumberTextController = TextEditingController();
  FocusNode vehicleNumberFocusNode = FocusNode();

  RxBool viewDetail = true.obs;

  Rx<VehiclesBrandDataModel> vehicleBrand = VehiclesBrandDataModel().obs;
  Rx<VehicleModels> vehicleModel = VehicleModels().obs;

  RxBool addVehicleLoading = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      vehicleBrand.value = Get.arguments['vehicle_brand_data'];
      vehicleModel.value = Get.arguments['vehicle_model_data'];
      brandTextController.text = vehicleBrand.value.name ?? '';
      modelTextController.text = vehicleModel.value.name ?? '';
      vehicleNumberTextController.text =
          Get.find<HomeController>().vehicleNumberTextController.text.trim();
    }
    super.onInit();
  }

  Future<void> addVehicle() async {
    try {
      addVehicleLoading.value = true;
      Map<String, dynamic> addVehicleRequestBody = {
        'vehicleBrand': vehicleBrand.value.sId,
        'vehicleModel': vehicleModel.value.sId,
        'vehicleNumber': vehicleNumberTextController.text.trim()
      };
      var response = await PostRequests.addVehicle(addVehicleRequestBody);
      if (response != null) {
        if (response.success!) {
          Future.delayed(const Duration(milliseconds: 800))
              .then((value) => _vehicleAddedBottomSheet(response.data?.sId));
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      addVehicleLoading.value = false;
    }
  }

  _vehicleAddedBottomSheet(String? sId) => CommonBottomSheetBackground.show(
      content: MessageBottomSheetContent(
          icon: AppImages.iconDoneCheck,
          messageText: 'vehicle_added_successfully'.tr,
          buttonText: 'ok'.tr,
          onButtonPress: () {
            Get.toNamed(AppRoutes.routeUpgradePlans, arguments: {
              'vehicleId' : sId
            });
          }),
      isDismissible: false);

}
