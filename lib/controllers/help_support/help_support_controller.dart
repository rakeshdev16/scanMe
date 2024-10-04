import 'package:scan_me_plus/export.dart';

class HelpSupportController extends GetxController {


  final GlobalKey<FormState> helpSupportFormKey = GlobalKey<FormState>();

  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController emailAddressTextController = TextEditingController();
  TextEditingController commentsTextController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailAddressFocusNode = FocusNode();
  FocusNode commentsFocusNode = FocusNode();

  RxBool helpSupportLoading = false.obs;

  Future<void> helpSupport() async {
    try {
      helpSupportLoading.value = true;
      Map<String, dynamic> helpSupportRequestBody = {
        "fullName": fullNameTextController.text.trim(),
        "email": emailAddressTextController.text.trim(),
        "comments": commentsTextController.text.trim()
      };
      var response = await PostRequests.helpSupport(helpSupportRequestBody);
      if (response != null) {
        if (response.success) {
          helpSupportFormKey.currentState?.reset();
          AppAlerts.success(message: response.message);
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      helpSupportLoading.value = false;
    }
  }
}
