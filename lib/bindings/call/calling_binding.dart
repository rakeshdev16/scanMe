import 'package:scan_me_plus/export.dart';

class CallingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallingController>(
            () => CallingController());
  }
}
