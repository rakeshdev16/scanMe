import 'package:scan_me_plus/export.dart';

class AlertNotificationsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'alerts'.tr),
    Tab(text: 'notifications'.tr),
  ];

  late TabController tabController;

  RxBool notificationsLoading = false.obs;
  RxList<NotificationsData> notificationList = <NotificationsData>[].obs;
  RxList<AlertNotificationsData> alertNotificationList =
      <AlertNotificationsData>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    getAlertNotificationsList();
  }

  @override
  void onReady() {
    super.onReady();
    Get.find<MainController>().getNewNotificationStatus();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  getNotificationsList() async {
    try {
      notificationsLoading.value = true;
      var result = await GetRequests.notificationList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            notificationList.value = result.data!;
            notificationList.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      notificationsLoading.value = false;
    }
  }

  getAlertNotificationsList() async {
    try {
      notificationsLoading.value = true;
      var result = await GetRequests.alertNotificationList();
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            alertNotificationList.value = result.data!;
            alertNotificationList.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      notificationsLoading.value = false;
    }
  }

  deleteAlertNotification(AlertNotificationsData alertNotificationsData) async {
    try {
      await DeleteRequests.deleteAlertNotification(
          alertNotificationsData.id ?? '');
      alertNotificationList.remove(alertNotificationsData);
      alertNotificationList.refresh();
    } finally {}
  }

  deleteNotification(NotificationsData notificationsData) async {
    try {
      await DeleteRequests.deleteNotification(notificationsData.id ?? '');
      notificationList.remove(notificationsData);
      notificationList.refresh();
    } finally {}
  }
}
