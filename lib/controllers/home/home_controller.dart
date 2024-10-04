import 'package:scan_me_plus/export.dart';

class HomeController extends GetxController {
  CarouselSliderController pageController = CarouselSliderController();

  TextEditingController searchTextController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  TextEditingController vehicleNumberTextController = TextEditingController();
  FocusNode vehicleNumberFocusNode = FocusNode();

  RxBool onAddVehicleTapped = false.obs;
  RxBool addNowEnable = false.obs;
  RxInt currentBannerIndex = 0.obs;

  RxBool isLoading = false.obs;
  RxBool searchVehicleLoading = false.obs;

 Rx<User?> user = PreferenceManager.user.obs;

  RxList<MyVehiclesDataModel> myVehiclesList = <MyVehiclesDataModel>[].obs;
  RxList<BannerData> bannerList = <BannerData>[].obs;

  Rx<SearchedVehicleDataModel> searchedVehicleData =
      SearchedVehicleDataModel().obs;

  RxBool callingStarted = false.obs;

  RxBool scanVehicleLoading = false.obs;

  Rx<StartCallData> startCallData = StartCallData().obs;

  @override
  void onInit() {
    getProfile();
    getMyVehicleList();
    getBannerList();
    super.onInit();
  }

  getProfile() async {
    try {
      var result = await GetRequests.fetchMyProfile();
      if (result != null) {
        if (result.success!) {
          user.value = result.data;
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      }
    } finally {}
  }

  getBannerList() async {
    try {
      isLoading.value = true;
      var result = await GetRequests.getBannerList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            bannerList.value = result.data!;
            bannerList.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      }
    } finally {
      isLoading.value = false;
    }
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
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchVehicle() async {
    try {
      searchVehicleLoading.value = true;
      FocusManager.instance.primaryFocus?.unfocus();
      Map<String, dynamic> searchVehicleRequestBody = {
        'vehicleNumber': searchTextController.text.trim()
      };
      var response = await PostRequests.searchVehicle(searchVehicleRequestBody);
      if (response != null) {
        if (response.success!) {
          if (response.data != null) {
            searchedVehicleData.value = response.data!;
            Get.find<MainController>().getEmergencyAlertList();
            _openDetails();
          }
        } else {
          _vehicleNotFoundBottomSheet();
          // AppAlerts.error(message: response.message ?? '');
        }
      } else {
        _vehicleNotFoundBottomSheet();
        // AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      searchVehicleLoading.value = false;
    }
  }

  _vehicleNotFoundBottomSheet() => CommonBottomSheetBackground.show(
      content: MessageBottomSheetContent(
          icon: AppImages.iconNoResult,
          messageText:
              '${'vehicle_not_found'.tr} \n${'enter_register_vehicle_number'.tr}',
          buttonText: 'ok'.tr,
          onButtonPress: () {
            Get.back();
          }));

  _openDetails() => CommonBottomSheetBackground.show(
      content: VehicleDetailBottomSheetContent(
        userName: '@${searchedVehicleData.value.user?.userId}',
        isBlockEnable: false,
        isFromHome: true,
        userId: searchedVehicleData.value.user?.sId ?? '',
        vehicleId: searchedVehicleData.value.sId ?? '',
        vehicleBrand: searchedVehicleData.value.vehicleBrand?.name ?? '',
        vehicleBrandImage: searchedVehicleData.value.vehicleBrand?.image ?? '',
        vehicleImage: searchedVehicleData.value.vehicleModel?.image ?? '',
        vehicleModel: searchedVehicleData.value.vehicleModel?.name ?? '',
        vehicleNumber: searchedVehicleData.value.vehicleNumber ?? '',
        isOwnVehicle: searchedVehicleData.value.user?.sId == user.value?.sId,
        isCalling: callingStarted,
        onCallStart: () async {
          callingStarted.value = true;
          startCall(
              receiverId: searchedVehicleData.value.user?.sId,
              vehicleId: searchedVehicleData.value.sId);
          return true;
        },
      ),
      topMargin: 6.h,
      isDismissible: false);

  Future<void> startCall({receiverId, vehicleId}) async {
    debugPrint("Start Call =====> ");
    try {
      Map<String, dynamic> startCallRequestBody = {
        "recieverId": receiverId,
        "vehicleId": vehicleId,
      };
      var response = await PostRequests.startCall(startCallRequestBody);
      if (response != null) {
        if (response.success!) {
          startCallData.value = response.data!;
          Get.toNamed(AppRoutes.routeCalling, arguments: {
            'channel': response.data?.channelName,
            'token': response.data?.token,
            '_id': response.data?.reciever?.id,
            'image': response.data?.reciever?.image,
            'userName': response.data?.reciever?.userId,
            'callBlocked': response.data?.callBlocked ?? false
          });
        } else {
          Get.back();
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        Get.back();
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {}
  }

  Future<void> deleteVehicleTemporarily(index) async {
    try {
      Map<String, dynamic> deleteVehicleRequestBody = {
        'isDeleted': !(myVehiclesList[index].isDeleted!)
      };
      var result = await PutRequests.deleteVehicleTemporarily(
          requestBody: deleteVehicleRequestBody, vehicleId: myVehiclesList[index].id);
      if (result != null) {
        if (result.success) {
          myVehiclesList[index].isDeleted = !(myVehiclesList[index].isDeleted!);
          myVehiclesList.refresh();
        } else {
          AppAlerts.error(message: result.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } on Exception catch (e) {
      debugPrint("Exception while updating user profile==> $e");
    }
  }

  deleteVehiclePermanently(MyVehiclesDataModel vehicleData) async {
    try {
      await DeleteRequests.deleteVehiclePermanently(vehicleData.id ?? '');
      myVehiclesList.remove(vehicleData);
    } finally {}
  }

  vehicleShippingStatus(context, shippingId) async {
    try {
      var result = await GetRequests.shippingStatus(shippingId);
      if (result != null) {
        if (result.success) {
          _shippingStatusBottomSheet(context, message: result.message);
        } else {
          AppAlerts.error(message: result.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {}
  }

  _shippingStatusBottomSheet(context, {message}) => CommonBottomSheetBackground.show(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ).paddingOnly(top: 5.h, bottom: 20.h),
        CustomButton(text: 'ok'.tr, onPressed: (){
          Get.back();
        })
            .paddingOnly(bottom: 10.h)
      ],
    )

  );
}
