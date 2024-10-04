import 'package:scan_me_plus/export.dart';

class MyProfileController extends GetxController {
  Rx<User?> user = PreferenceManager.user.obs;

  RxList<AccountItems> accountItemsList = <AccountItems>[
    AccountItems(icon: AppImages.iconReferFriend, text: 'refer_friend'.tr),
    AccountItems(icon: AppImages.iconSociety, text: 'society_hotel_signup'.tr),
    AccountItems(icon: AppImages.iconAbout, text: 'about'.tr),
    AccountItems(icon: AppImages.iconHelpSupport, text: 'help_support'.tr),
    AccountItems(icon: AppImages.iconBin, text: 'delete_account'.tr),
    AccountItems(icon: AppImages.iconLogout, text: 'logout'.tr),
  ].obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() async {
    try {
      var result = await GetRequests.fetchMyProfile();
      if (result != null) {
        if (result.success!) {
          PreferenceManager.user = result.data;
          user.value = PreferenceManager.user;
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      }
    } finally {
    }
  }

  void updateFcmToken() async {
      try {
        Map<String, dynamic> requestBody = {'fcmToken': ''};
        var result = await PostRequests.updateFCMToken(requestBody);
        if (result != null) {
          if (result.success) {
            PreferenceManager.logoutUser();
          } else {
            AppAlerts.error(message: result.message ?? '');
          }
        }
      } on Exception catch (e) {
        debugPrint("Error facing while updating Fcm token --->>>> $e");
      }
  }

  void deleteAccount() async {
      try {
        var result = await DeleteRequests.deleteAccount();
        if (result != null) {
          if (result.success) {
            PreferenceManager.logoutUser();
          } else {
            AppAlerts.error(message: result.message ?? '');
          }
        }
      } on Exception catch (e) {
        debugPrint("Error facing while updating Fcm token --->>>> $e");
      }
  }
}

class AccountItems {
  String icon;
  String text;
  AccountItems({required this.icon, required this.text});
}
