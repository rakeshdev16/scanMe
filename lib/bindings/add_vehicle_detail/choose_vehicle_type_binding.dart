import 'package:scan_me_plus/export.dart';

class ChooseVehicleTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseVehicleTypeController>(
        () => ChooseVehicleTypeController());
  }
}
