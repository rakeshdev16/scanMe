
import 'package:scan_me_plus/export.dart';

class SocietyHotelSignupController extends GetxController{

  RxList imagesList = [
    AppImages.comingSoonBarrier,
    AppImages.comingSoonCommunity,
    AppImages.comingSoonHotel,
    AppImages.comingSoonSociety,
  ].obs;

  Timer? _timer;

  @override
  void onInit() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      imagesList.shuffle();
    });
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}