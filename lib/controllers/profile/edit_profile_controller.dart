import 'package:scan_me_plus/export.dart';

class EditProfileController extends GetxController {
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

  Rx<User?> user = PreferenceManager.user.obs;

  Rx<StatesDataModel> statesData = StatesDataModel().obs;

  RxBool isLoading = false.obs;
  RxBool registerLoading = false.obs;

  @override
  void onInit() {
    getStateList();
    initFormFields();
    super.onInit();
  }

  RxString profileImage = "".obs;

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImage.value = file.path;
      profileImage.refresh();
    }
  }

  initFormFields() {
    firstNameTextController.text = user.value?.firstName ?? '';
    lastNameTextController.text = user.value?.lastName ?? '';
    emailAddressTextController.text = user.value?.email ?? '';
    userIDTextController.text = user.value?.userId ?? '';
    pinCodeTextController.text = user.value?.pincode ?? '';
    addressTextController.text = user.value?.address ?? '';
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
            for (var element in stateList) {
              if (element.name == user.value?.state) {
                selectedState.value = element.name ?? '';
                if (element.cities != null) {
                  cityList.value = element.cities!;
                  for (var cityElement in element.cities!) {
                    if (cityElement.name == user.value?.city) {
                      selectedCity.value = cityElement.name ?? '';
                    }
                  }
                }
              }
            }
            selectedState.refresh();
            selectedCity.refresh();
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

  void updateProfile() async {
    try {
      registerLoading.value = true;
      Map<String, dynamic> imagesData = {'file': profileImage.value};
      var result = await PostRequests.uploadFile(imagesData);
      if (result != null) {
        if (result.success!) {
          updateUser(image: result.data?.path);
        } else {
          AppAlerts.error(message: result.message!);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      registerLoading.value = false;
    }
  }

  Future<void> updateUser({image}) async {
    try {
      Map<String, String> registerRequestBody = {
        'firstName': firstNameTextController.text.trim(),
        'lastName': lastNameTextController.text.trim(),
        if (image != null) 'image': image,
        'pincode': pinCodeTextController.text.trim(),
        'state': selectedState.value,
        'city': selectedCity.value,
        'address': addressTextController.text.trim(),
      };
      var response = await PostRequests.updateUser(registerRequestBody);
      if (response != null) {
        if (response.success!) {
          PreferenceManager.user = response.data;
          Get.offAllNamed(AppRoutes.routeHome, arguments: {'selected_tab': 4});
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        registerLoading.value = false;
      });
    }
  }
}
