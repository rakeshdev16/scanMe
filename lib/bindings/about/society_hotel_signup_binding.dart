import 'package:scan_me_plus/export.dart';

class SocietyHotelSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocietyHotelSignupController>(() => SocietyHotelSignupController());
  }
}
