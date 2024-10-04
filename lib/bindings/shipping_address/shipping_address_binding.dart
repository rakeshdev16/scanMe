import 'package:scan_me_plus/export.dart';

class ShippingAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShippingAddressController>(() => ShippingAddressController());
  }
}
