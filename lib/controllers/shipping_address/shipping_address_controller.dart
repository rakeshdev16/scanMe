import 'package:scan_me_plus/export.dart';

class ShippingAddressController extends GetxController {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode pinCodeFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  Rx<StatesDataModel> statesData = StatesDataModel().obs;

  RxList<States> stateList = <States>[].obs;
  RxList<Cities> cityList = <Cities>[].obs;

  Rx<String> selectedState = ''.obs;
  Rx<String> selectedCity = ''.obs;

  RxBool fromReplacement = false.obs;
  RxBool statesLoading = false.obs;
  RxBool shippingAddressLoading = false.obs;

  RxString vehicleId = ''.obs;

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments['fromReplacement'] != null){
        fromReplacement.value = Get.arguments['fromReplacement'];
      }
      if (Get.arguments['vehicleId'] != null) {
        vehicleId.value = Get.arguments['vehicleId'];
      }
    }
    getStateList();
    super.onInit();
  }


  getStateList() async {
    try {
      statesLoading.value = true;
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
      statesLoading.value = false;
    }
  }


  Future<void> addShippingAddress(context) async {
    try {
      shippingAddressLoading.value = true;
      Map<String, dynamic> shippingAddressRequestBody = {
        "firstName": firstNameTextController.text.trim(),
        "lastName": lastNameTextController.text.trim(),
        "pinCode": pinCodeTextController.text.trim(),
        "state": selectedState.value,
        "city": selectedCity.value,
        "address": addressTextController.text.trim()
      };
      var response =
      await PostRequests.addShippingAddress(shippingAddressRequestBody);
      if (response != null) {
        if (response.success!) {
          if(fromReplacement.value){
            Get.back(result: true);
          }else{
            shippingOrders(id : response.data?.id);
            _qrOrderPlacedBottomSheet(context);
          }
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      shippingAddressLoading.value = false;
    }
  }

  _qrOrderPlacedBottomSheet(context) => CommonBottomSheetBackground.show(
      content: PopScope(
        canPop: false,
        onPopInvoked: (value) {
          Get.offAllNamed(AppRoutes.routeHome);
        },
        child: Column(
          children: [
            Text('qr_order_successful'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge),
            CustomButton(
                text: 'ok'.tr,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                onPressed: () {
                  Get.offAllNamed(AppRoutes.routeHome);
                }).paddingOnly(top: 15.h, bottom: 8.h)
          ],
        ),
      ),
      isDismissible: false
  );

  Future<void> shippingOrders({id}) async {
    try {
      Map<String, dynamic> shippingOrderRequestBody = {
        "shippingAddress": id,
        "vehicle": vehicleId.value
      };
      var response =
      await PostRequests.shippingOrder(shippingOrderRequestBody);
      if (response != null) {
        if (response.success) {

        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
    }
  }

}
