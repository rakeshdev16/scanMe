import 'package:scan_me_plus/export.dart';

class PurchaseListController extends GetxController {

  RxBool isLoading = false.obs;

  RxList<MyVehiclesDataModel> myVehiclesList = <MyVehiclesDataModel>[].obs;

  @override
  void onInit() {
    getMyVehicleList();
    super.onInit();
  }

  getMyVehicleList() async {
    try {
      isLoading.value = true;
      var result = await GetRequests.fetchMyVehiclesList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            myVehiclesList.value = result.data!;
            myVehiclesList.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isLoading.value = false;
    }
  }

}
