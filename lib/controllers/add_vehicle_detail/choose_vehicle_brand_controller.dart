import 'package:scan_me_plus/export.dart';

class ChooseVehicleBrandController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  RxList<VehiclesBrandDataModel> vehicleBrandsList =
      <VehiclesBrandDataModel>[].obs;
  RxList<VehiclesBrandDataModel> vehicleBrandsListToShow =
      <VehiclesBrandDataModel>[].obs;

  RxString vehicleType = ''.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      vehicleType.value = Get.arguments['vehicle_type'];
      getVehicleBrandList();
    }
    super.onInit();
  }

  getVehicleBrandList() async {
    try {
      isLoading.value = true;
      var result =
          await GetRequests.fetchVehiclesBrand(vehicleType: vehicleType.value);
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            vehicleBrandsList.value = result.data!;
            vehicleBrandsListToShow.value = result.data!;
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
