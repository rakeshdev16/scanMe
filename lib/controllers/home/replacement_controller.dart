import 'package:scan_me_plus/export.dart';

class ReplacementController extends GetxController {
  TextEditingController commentsTextController = TextEditingController();
  FocusNode commentsFocusNode = FocusNode();
  FocusNode reasonsFocusNode = FocusNode();

  RxBool addressLoading = false.obs;
  RxBool replacementRequestLoading = false.obs;

  Rx<MyVehiclesDataModel> vehicleData = MyVehiclesDataModel().obs;
  RxList<ShippingAddressData> shippingAddressList = <ShippingAddressData>[].obs;

  RxList<String> reasonsList =
      <String>['QR Code is missing', 'Wear and Tear', 'Damaged', 'Others'].obs;

  Rx<String> selectedReason = ''.obs;
  Rx<String> selectedAddress = ''.obs;
  RxInt reasonNotSelected = (-1).obs;
  RxInt addressNotSelected = (-1).obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      vehicleData.value = Get.arguments['vehicleData'];
    }
    getShippingAddressesList();
    super.onInit();
  }

  getShippingAddressesList() async {
    try {
      addressLoading.value = true;
      var result = await GetRequests.shippingAddressList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            shippingAddressList.value = result.data!;
            shippingAddressList.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      addressLoading.value = false;
    }
  }

  Future<void> replacementRequest() async {
    try {
      replacementRequestLoading.value = true;
      Map<String, dynamic> replacementRequestBody = {
        "reason": selectedReason.value,
        "comments": commentsTextController.text.trim(),
        "shippingAddress": selectedAddress.value,
        "vehicle": vehicleData.value.id
      };
      var response =
          await PostRequests.replacementRequest(replacementRequestBody);
      if (response != null) {
        if (response.success!) {
          Get.back();
          AppAlerts.success(message: response.message ?? '');
          shippingOrders(id: response.data?.id ?? '');
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      replacementRequestLoading.value = false;
    }
  }

  Future<void> shippingOrders({id}) async {
    try {
      Map<String, dynamic> shippingOrderRequestBody = {
        "shippingAddress": selectedAddress.value,
        "vehicle": vehicleData.value.id,
        "replacementRequest": id
      };
      var response = await PostRequests.shippingOrder(shippingOrderRequestBody);
      if (response != null) {
        if (response.success) {
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {}
  }
}
