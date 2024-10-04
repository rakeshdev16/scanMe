import 'package:scan_me_plus/export.dart';

class NotificationAlertController extends GetxController {

  RxString alert = ''.obs;

  final player = AudioPlayer();

  late final StreamController overlayStream;


  @override
  void onInit() {
    if(Get.arguments != null){
      alert.value = Get.arguments['emergencyAlert'];
      player.play(AssetSource('raw/emergency_alert.mp3'), volume: 10);
          player.setReleaseMode(ReleaseMode.loop);
    }
    super.onInit();
  }

  @override
  void onClose() {
    player.pause();
    super.onClose();
  }

}
