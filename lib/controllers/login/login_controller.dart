import 'package:scan_me_plus/export.dart';

class LoginController extends GetxController {
  TextEditingController mobileNumberTextController = TextEditingController();
  FocusNode mobileNumberFocusNode = FocusNode();

  RxBool isLoading = false.obs;

  Worker? phoneNumberChangeListenerWorker;

  RxBool isPhoneNumberExist = false.obs;
  RxBool isShowPhoneExist = false.obs;

  @override
  void onInit() {
    setupPhoneNumberTextChangeListener();
    super.onInit();
  }

  void setupPhoneNumberTextChangeListener() {
    RxString phoneNumber = ''.obs;
    phoneNumberChangeListenerWorker = debounce(
        phoneNumber,
        (callback) => checkPhoneNumberExist(
            countryCode: '+91', phoneNumber: phoneNumber.value));

    mobileNumberTextController.addListener(() {
      phoneNumber.value = mobileNumberTextController.text.toString().trim();
      if (isShowPhoneExist.value) {
        isShowPhoneExist.value = false;
      }
    });
  }

  checkPhoneNumberExist({phoneNumber, countryCode}) async {
    if (AppFormatters.validPhoneExp.hasMatch(phoneNumber)) {
      var requestBody = {'countryCode': countryCode, 'mobile': phoneNumber};
      isPhoneNumberExist.value =
          await PostRequests.checkMobileNumberExist(requestBody);
      if (isPhoneNumberExist.value) {
        isShowPhoneExist.value = true;
      } else {
        isShowPhoneExist.value = true;
      }
    }
  }

  getOtpClick() {
    Map<String, dynamic> loginData = {
      'otpCode': '',
      'countryCode': '+91',
      'mobile': mobileNumberTextController.text.trim(),
    };
    Get.offAllNamed(AppRoutes.routeOtpVerification,
        arguments: {/*'from_login': true,*/ 'login_data': loginData});
  }

  /*getOtpClick(){
    if(isPhoneNumberExist.value){
      Map<String, dynamic> loginData = {
        'otpCode': '',
        'countryCode': '+91',
        'mobile': mobileNumberTextController.text.trim(),
      };
      Get.offAllNamed(AppRoutes.routeOtpVerification,
          arguments: {'from_login': true, 'login_data': loginData});
    }else{
      Get.offAllNamed(AppRoutes.routeAddProfileDetails, arguments: {
        'phone_number' : mobileNumberTextController.text.trim(),
        'country_code' : '+91'
      });
    }
  }*/
}
