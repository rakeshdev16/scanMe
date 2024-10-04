import 'package:scan_me_plus/export.dart';

class ChooseVehicleModelController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  Rx<VehiclesBrandDataModel> vehicleBrand = VehiclesBrandDataModel().obs;

  RxList<VehicleModels> vehicleModelsList = <VehicleModels>[].obs;
  RxList<VehicleModels> vehicleModelsListToShow = <VehicleModels>[].obs;

  RxBool isLoading = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      isLoading.value = true;
      vehicleBrand.value = Get.arguments['vehicle_brand_data'];
      vehicleModelsList.value = vehicleBrand.value.vehicleModels ?? [];
      vehicleModelsListToShow.value = vehicleBrand.value.vehicleModels ?? [];
      isLoading.value = false;
    }
    super.onInit();
  }
}
