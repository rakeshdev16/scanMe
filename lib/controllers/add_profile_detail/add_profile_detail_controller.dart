import 'package:scan_me_plus/export.dart';

class AddProfileDetailController extends GetxController {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController emailAddressTextController = TextEditingController();
  TextEditingController userIDTextController = TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailAddressFocusNode = FocusNode();
  FocusNode userIdFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  RxList<States> stateList = <States>[].obs;
  RxList<Cities> cityList = <Cities>[].obs;

  Rx<String> selectedState = ''.obs;
  Rx<String> selectedCity = ''.obs;

  Rx<StatesDataModel> statesData = StatesDataModel().obs;

  Worker? emailChangeListenerWorker;
  Worker? userIdListenerWorker;

  RxBool isEmailExist = false.obs;
  RxBool isShowEmailExist = false.obs;
  RxBool isUserIdExist = false.obs;
  RxInt isShowsUserIdExist = (-1).obs;
  RxString userIdValue = ''.obs;

  RxBool isLoading = false.obs;
  RxBool isFromHome = false.obs;

  RxBool registerLoading = false.obs;

  @override
  void onInit() {
    getStateList();
    if (Get.arguments != null) {
      isFromHome.value = Get.arguments['from_home'];
    }
    setupEmailTextChangeListener();
    setupUserIdTextChangeListener();
    super.onInit();
  }

  getStateList() async {
    try {
      isLoading.value = true;
      var result = await GetRequests.fetchStateList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            statesData.value = result.data!;
            stateList.value = statesData.value.states!;
          }
        } else {
          AppAlerts.error(message: result.message!);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void setupEmailTextChangeListener() {
    RxString email = ''.obs;
    emailChangeListenerWorker =
        debounce(email, (callback) => checkEmailExist(email.value));
    emailAddressTextController.addListener(() {
      email.value = emailAddressTextController.text.toString().trim();
      if (isShowEmailExist.value) {
        isShowEmailExist.value = false;
      }
    });
  }

  checkEmailExist(String email) async {
    if (AppFormatters.validEmailExp.hasMatch(email)) {
      isEmailExist.value = await PostRequests.checkEmailExist(email);
      if (isEmailExist.value) {
        isShowEmailExist.value = true;
      } else {
        isShowEmailExist.value = false;
      }
    }
  }

  void setupUserIdTextChangeListener() {
    RxString userId = ''.obs;
    userIdListenerWorker =
        debounce(userId, (callback) => checkUserIdExist(userId.value));

    userIDTextController.addListener(() {
      userId.value = userIDTextController.text.toString().trim();
      userIdValue.value = userIDTextController.text.toString().trim();
      if (isShowsUserIdExist.value == 0 ) {
        isShowsUserIdExist.value = 1;
      }
    });
  }

  checkUserIdExist(String userId) async {
    if (userId.toString().trim().isNotEmpty) {
      isUserIdExist.value = await PostRequests.checkUserIdExist(userId);
      if (isUserIdExist.value) {
        isShowsUserIdExist.value = 0;
      } else {
        isShowsUserIdExist.value = 1;
      }
    }
  }

  Future<void> registerUser() async {
    try {
      registerLoading.value = true;
      Map<String, dynamic> registerRequestBody = {
        'email': emailAddressTextController.text.trim(),
        'userId': userIDTextController.text.trim(),
        'firstName': firstNameTextController.text.trim(),
        'lastName': lastNameTextController.text.trim(),
        'pincode': pinCodeTextController.text.trim(),
        'state': selectedState.value,
        'city': selectedCity.value,
        'address': addressTextController.text.trim(),
      };
      var response = await PostRequests.registerUser(registerRequestBody);
      if (response != null) {
        if (response.success!) {
          saveDataToPref(response.data);
          Future.delayed(const Duration(milliseconds: 800)).then((value) =>
              Get.offAllNamed(AppRoutes.routeHome,
                  arguments: {'selected_tab': isFromHome.value ? 4 : 0}));
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


  void saveDataToPref(User? user) {
    PreferenceManager.user = user;
  }
}
