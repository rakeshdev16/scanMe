import 'package:scan_me_plus/export.dart';

class BlockedUsersListController extends GetxController {

  RxBool usersLoading = false.obs;
  RxBool isBlocking = false.obs;
  RxList<BlockedUserData> blockedUsersList = <BlockedUserData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBlockedUsersList();
  }

  getBlockedUsersList() async {
    try {
      usersLoading.value = true;
      var result = await GetRequests.blockedUsersList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            blockedUsersList.value = result.data!;
            blockedUsersList.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      usersLoading.value = false;
    }
  }

  Future<void> unblockUser(BlockedUserData blockedUserData) async {
    try {
      isBlocking.value = true;
      var response = await PostRequests.blockUnblockUser(
          blockStatus : AppConsts.unblock,
          userId: blockedUserData.blockedUser?.sId ?? '');
      if (response != null) {
        if (response.success) {

          blockedUsersList.remove(blockedUserData);
          blockedUsersList.refresh();

        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isBlocking.value = false;
    }
  }


}
