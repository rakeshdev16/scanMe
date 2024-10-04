import 'package:scan_me_plus/export.dart';

class ChooseVehicleModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseVehicleModelController>(
        () => ChooseVehicleModelController());
  }
}
