import 'package:scan_me_plus/export.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationController>(() => OtpVerificationController());
  }
}
