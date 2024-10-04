import 'package:scan_me_plus/export.dart';

class AlertNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlertNotificationsController>(
        () => AlertNotificationsController());
  }
}
