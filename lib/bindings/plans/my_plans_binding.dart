import 'package:scan_me_plus/export.dart';

class MyPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPlansController>(() => MyPlansController());
  }
}

