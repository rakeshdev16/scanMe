import 'package:scan_me_plus/export.dart';

class CallHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'all'.tr),
    Tab(text: 'missed'.tr),
  ];

  late TabController tabController;

  RxBool callingStarted = false.obs;

  RxBool isLoading = false.obs;
  RxBool isDetailLoading = false.obs;
  RxBool isBlocking = false.obs;

  Rx<User?> user = PreferenceManager.user.obs;

  RxList<CallHistoryData> allCallsList = <CallHistoryData>[].obs;
  RxList<CallHistoryData> missedCallsList = <CallHistoryData>[].obs;
  Rx<CallDetailModel> callDetail = CallDetailModel().obs;

  Rx<StartCallData> startCallData = StartCallData().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    getCallHistoryList();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  getCallHistoryList({isMissedCall = false}) async {
    try {
      isLoading.value = true;
      var result = await GetRequests.fetchCallHistoryList(
          status: isMissedCall ? AppConsts.notAnswered : '');
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            if (isMissedCall) {
              missedCallsList.value = result.data!;
              missedCallsList.refresh();
            } else {
              allCallsList.value = result.data!;
              allCallsList.refresh();
            }
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

  String formatCallTime(DateTime callTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    if (callTime.year == now.year &&
        callTime.month == now.month &&
        callTime.day == now.day) {
      // If the call occurred today
      return DateFormat('hh:mm a').format(callTime); // Format as hh:mm a
    } else if (callTime.year == yesterday.year &&
        callTime.month == yesterday.month &&
        callTime.day == yesterday.day) {
      // If the call occurred yesterday
      return 'Yesterday'; // Format as Yesterday hh:mm a
    } else if (callTime.isAfter(startOfWeek)) {
      // If the call occurred within this week
      return DateFormat('EEEE').format(callTime); // Format as Weekday hh:mm a
    } else {
      // If the call occurred before this week
      return DateFormat('dd/MM/yyyy').format(callTime); // Format as MMM d, yyyy
    }
  }

  getCallDetail(callId) async {
    try {
      isDetailLoading.value = true;
      var result = await GetRequests.callDetail(callId);
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            callDetail.value = result.data!;
            callDetail.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isDetailLoading.value = false;
    }
  }

  deleteCallData(CallHistoryData callData, {isMissedCall = false}) async {
    try {
      await DeleteRequests.deleteCall(callData.id ?? '');
      if (isMissedCall) {
        missedCallsList.remove(callData);
        missedCallsList.refresh();
      } else {
        allCallsList.remove(callData);
        allCallsList.refresh();
      }
    } finally {}
  }

  Future<void> blockUnblockUser({blockStatus, userId}) async {
    try {
      isBlocking.value = true;
      var response = await PostRequests.blockUnblockUser(
          blockStatus: blockStatus, userId: userId);
      if (response != null) {
        if (response.success) {
          callDetail.value.isBlockedUser = !callDetail.value.isBlockedUser!;
          callDetail.refresh();
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isBlocking.value = false;
    }
  }

  Future<void> startCall({receiverId, vehicleId}) async {
    try {
      callingStarted.value = true;
      Map<String, dynamic> startCallRequestBody = {
        "recieverId": receiverId,
        "vehicleId": vehicleId,
      };
      var response = await PostRequests.startCall(startCallRequestBody);
      if (response != null) {
        if (response.success!) {
          startCallData.value = response.data!;
          debugPrint(' ======> ${response.data}');
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
          callingStarted.value = false;
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        Get.back();
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      callingStarted.value = false;
    }
  }

  String convertSecondsToHHMMSS(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '${hoursStr != '00' ? '$hoursStr h' : ''}${minutesStr != '00' ? '$minutesStr m' : ''}${hoursStr == '00' && minutesStr == '00' ? '$secondsStr s' : secondsStr}';
  }
}
