import 'package:scan_me_plus/export.dart';

class ChooseVehicleBrandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseVehicleBrandController>(
        () => ChooseVehicleBrandController());
  }
}
