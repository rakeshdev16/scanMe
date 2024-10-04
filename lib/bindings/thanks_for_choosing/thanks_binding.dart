import 'package:scan_me_plus/export.dart';

class ThanksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThanksController>(() => ThanksController());
  }
}
