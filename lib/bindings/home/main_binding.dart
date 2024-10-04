import 'package:scan_me_plus/export.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CallHistoryController>(() => CallHistoryController());
    Get.lazyPut<PurchaseListController>(() => PurchaseListController());
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}
