import 'package:scan_me_plus/export.dart';

class AddProfileDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProfileDetailController>(() => AddProfileDetailController());
  }
}
