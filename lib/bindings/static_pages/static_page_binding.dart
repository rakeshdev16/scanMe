import 'package:scan_me_plus/export.dart';

class StaticPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaticPageController>(() => StaticPageController());
  }
}
