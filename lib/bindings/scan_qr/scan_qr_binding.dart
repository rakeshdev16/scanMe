import 'package:scan_me_plus/export.dart';

class ScanQRBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQRController>(() => ScanQRController());
  }
}
