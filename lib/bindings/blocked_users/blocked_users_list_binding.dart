import 'package:scan_me_plus/export.dart';

class BlockedUsersListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockedUsersListController>(() => BlockedUsersListController());
  }
}