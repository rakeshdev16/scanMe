import 'package:scan_me_plus/export.dart';

class NotificationAlertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationAlertController>(() => NotificationAlertController());
  }
}