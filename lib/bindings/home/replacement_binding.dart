import 'package:scan_me_plus/export.dart';

class ReplacementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReplacementController>(() => ReplacementController());
  }
}
