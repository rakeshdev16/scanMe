import 'package:scan_me_plus/export.dart';

const int timerCount = 60;

class OtpVerificationController extends GetxController /*with CodeAutoFill*/{
  TextEditingController otpTextController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();

  RxBool registerLoading = false.obs;
  RxBool isLoading = false.obs;
  RxString otpErrorMessage = ''.obs;
  RxString otpCode = ''.obs;
  String signature = "{{ app signature }}";

  Map<String, dynamic>? loginRequestBody;

  Timer? _timer;
  final RxInt start = timerCount.obs;

  @override
  void onInit() {
    // getSignature();
    // listenForCode();
    // listenOTP();
    if (Get.arguments != null) {
      /*isFromLogin.value = Get.arguments['from_login'] ?? false;
      if (isFromLogin.value) {*/
      loginRequestBody = Get.arguments['login_data'];
      /* } else {
        registerRequestBody = Get.arguments['register_data'];
      }*/
      requestOTP();
    }
    super.onInit();
  }

 /* @override
  void codeUpdated() {
    print('--> ${code}');
    otpCode.value = code!;
    print('--> ${otpCode.value}');
  }

  void listenOTP() async {
    print('--> listen for code');
    await SmsAutoFill().listenForCode;
  }

  void getSignature() async {
    print('--> signature');
    final String signature = await SmsAutoFill().getAppSignature;
    print("Signature: $signature");
  }
*/
  startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (start.value == 0) {
        _timer?.cancel();
      } else {
        start.value--;
      }
    });
  }

  Future<void> requestOTP() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> requestLoginData = {
        'countryCode': loginRequestBody?['countryCode'],
        'mobile': loginRequestBody?['mobile'],
      };
      /* Map<String, dynamic> requestRegisterData = {
        'countryCode': registerRequestBody?['countryCode'],
        'mobile': registerRequestBody?['mobile'],
      };*/
      var response = await PostRequests.requestOtp(requestLoginData);
      // isFromLogin.value ? requestLoginData : requestRegisterData);
      if (response != null) {
        if (response.success) {
          // otpTextController.text = response.data!.otpCode!;
          // loginRequestBody!['otpCode'] = response.data!.otpCode!;
          /* if (isFromLogin.value) {
            loginRequestBody!['otpCode'] = response.data!.otpCode!;
          } else {
            registerRequestBody!['otpCode'] = response.data!.otpCode!;
          }*/
          start.value = timerCount;
          startTimer();
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void requestResendOtp() {
    otpTextController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    requestOTP();
  }

  /*Future<void> registerUser() async {
    try {
      registerLoading.value = true;
      var response = await PostRequests.registerUser(registerRequestBody!);
      if (response != null) {
        if (response.success!) {
          saveDataToPref(response.data);
          Future.delayed(const Duration(milliseconds: 800))
              .then((value) => Get.offAllNamed(AppRoutes.routeHome));
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      registerLoading.value = false;
    }
  }*/

  Future<void> loginUser() async {
    try {
      registerLoading.value = true;
      var response = await PostRequests.loginUser(loginRequestBody!);
      if (response != null) {
        if (response.success!) {
          saveDataToPref(response.data);
          Future.delayed(const Duration(milliseconds: 800)).then((value) {
            if (response.data?.isNewUser == true) {
              Get.offAllNamed(AppRoutes.routeAddProfileDetails);
            } else {
              Get.offAllNamed(AppRoutes.routeHome);
            }
          });
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      registerLoading.value = false;
    }
  }

  onOtpTextFieldChange(String value) {
    if (value.length == 4) {
      FocusManager.instance.primaryFocus?.unfocus();
      otpCode.value = value;
      loginRequestBody?['otpCode'] = otpCode.value;
      /* var otp = isFromLogin.value
          ? (loginRequestBody?['otpCode'])
          : (registerRequestBody?['otpCode']);*/
      // if (otp == value) {
      //   otpErrorMessage.value = '';
      loginUser();
      /*if (isFromLogin.value) {
          loginUser();
        } else {
          registerUser();
        }*/
      // } else {
      //   otpErrorMessage.value = 'otp_does_not_match'.tr;
      // }
    } else {
      otpErrorMessage.value = '';
    }
  }

  void saveDataToPref(User? user) {
    PreferenceManager.user = user;
    PreferenceManager.userToken = user?.token;
  }

  @override
  void dispose() {
    _timer?.cancel();
    // SmsAutoFill().unregisterListener();
    // cancel();
    super.dispose();
  }

  @override
  void onClose() {
    _timer?.cancel();
    // SmsAutoFill().unregisterListener();
    // cancel();
    super.onClose();
  }
}
