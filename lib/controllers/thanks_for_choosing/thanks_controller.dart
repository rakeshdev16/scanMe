import 'package:scan_me_plus/export.dart';

class ThanksController extends GetxController {

  RxString vehicleId = ''.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      vehicleId.value = Get.arguments['vehicleId'];
    }
    super.onInit();
  }
}
