import 'package:scan_me_plus/export.dart';

class AlertNotificationsScreen extends GetView<AlertNotificationsController> {
  const AlertNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'alert_notifications'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.tabController,
            tabs: controller.myTabs,
            unselectedLabelColor: Colors.white,
            labelColor: AppColors.kPrimaryColor,
            physics: const NeverScrollableScrollPhysics(),
            onTap: (tab) {
              if (tab == 0) {
                controller.getAlertNotificationsList();
              } else {
                controller.getNotificationsList();
              }
            },
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
          ).paddingOnly(top: 5.h),
          Expanded(
            child: TabBarView(
                controller: controller.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _alertsList(context),
                  _notificationsList(context),
                ]),
          ),
        ],
      ),
    );
  }

  _alertsList(context) => Obx(
        () => controller.notificationsLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.alertNotificationList.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.alertNotificationList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        controller.deleteAlertNotification(
                            controller.alertNotificationList[index]);
                      },
                      background: Container(
                        color: AppColors.redColor,
                        alignment: Alignment.centerRight,
                        child: Text('delete'.tr,
                                style: Theme.of(context).textTheme.bodyMedium)
                            .paddingSymmetric(horizontal: 20.w),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '@${controller.alertNotificationList[index].user != null ? controller.alertNotificationList[index].user?.userId : controller.alertNotificationList[index].otherUserMobile != null && controller.alertNotificationList[index].otherUserMobile != "" ? controller.alertNotificationList[index].otherUserMobile : "anonymousUser"}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColors.kPrimaryColor)),
                                  Text(
                                          controller
                                                  .alertNotificationList[index]
                                                  .emergencyAlert
                                                  ?.name ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                      .paddingOnly(top: 3.h),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                                controller.alertNotificationList[index].time !=
                                        null
                                    ? controller.formatDateTime(controller
                                        .alertNotificationList[index].time!)
                                    : '',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.white10,
                    ),
                  ).paddingSymmetric(vertical: 10.h, horizontal: 15.w)
                : const EmptyStateWidget().paddingSymmetric(vertical: 120.h),
      );

  _notificationsList(context) => Obx(
        () => controller.notificationsLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.notificationList.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.notificationList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        controller.deleteNotification(
                          controller.notificationList[index],
                        );
                      },
                      background: Container(
                        color: AppColors.redColor,
                        alignment: Alignment.centerRight,
                        child: Text('delete'.tr,
                                style: Theme.of(context).textTheme.bodyMedium)
                            .paddingSymmetric(horizontal: 20.w),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                    controller.notificationList[index].text ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                                .paddingSymmetric(vertical: 15.h),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                              controller.notificationList[index].time != null
                                  ? controller.formatDateTime(
                                      controller.notificationList[index].time!)
                                  : '',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.white10,
                    ),
                  ).paddingSymmetric(vertical: 10.h, horizontal: 15.w)
                : const EmptyStateWidget().paddingSymmetric(vertical: 120.h),
      );
}
