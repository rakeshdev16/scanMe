import 'package:scan_me_plus/export.dart';

class ReferAFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferAFriendController>(() => ReferAFriendController());
  }
}
