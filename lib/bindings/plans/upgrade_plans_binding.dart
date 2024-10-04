import 'package:scan_me_plus/export.dart';

class UpgradePlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpgradePlansController>(() => UpgradePlansController());
  }
}
