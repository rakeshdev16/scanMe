import 'package:scan_me_plus/export.dart';

class CallHistoryScreen extends GetView<CallHistoryController> {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'calls'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        isLeadingVisible: false,
        widgets: [_popUpMenu(context)],
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
                controller.getCallHistoryList();
              } else {
                controller.getCallHistoryList(isMissedCall: true);
              }
            },
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
          ).paddingOnly(top: 5.h),
          Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: [
                  _allCalls(context),
                  _missedCalls(context),
                ]),
          ),
        ],
      ),
    );
  }

  _popUpMenu(context) => Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: const DividerThemeData(
            color: Colors.white24,
          ),
        ),
        child: PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
                value: 1,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                child: SizedBox(
                  height: 18.h,
                  child: Text(
                    "blocked_users".tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).paddingOnly(bottom: 4.h),
                )),
          ],
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tightFor(
            width: 140.w,
          ),
          icon: Image.asset(
            AppImages.iconMore,
            height: 12.h,
            color: Colors.white,
          ),
          position: PopupMenuPosition.under,
          popUpAnimationStyle: AnimationStyle(
              curve: Curves.ease, duration: const Duration(seconds: 1)),
          color: Colors.black87.withOpacity(0.8),
          elevation: 0,
          onSelected: (value) {
            if (value == 1) {
              Get.toNamed(AppRoutes.routeBlockedUsers);
            }
          },
        ),
      );

  _allCalls(context) => Obx(
        () => controller.isLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.allCallsList.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.allCallsList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        controller
                            .deleteCallData(controller.allCallsList[index]);
                      },
                      background: Container(
                        color: AppColors.redColor,
                        alignment: Alignment.centerRight,
                        child: Text('delete'.tr,
                                style: Theme.of(context).textTheme.bodyMedium)
                            .paddingSymmetric(horizontal: 20.w),
                      ),
                      child: _callView(context, controller.allCallsList[index]),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(),
                  ).paddingSymmetric(vertical: 10.h)
                : const EmptyStateWidget().paddingSymmetric(vertical: 120.h),
      );

  _missedCalls(context) => Obx(
        () => controller.isLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.missedCallsList.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.missedCallsList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        controller.deleteCallData(
                            controller.missedCallsList[index],
                            isMissedCall: true);
                      },
                      background: Container(
                        color: AppColors.redColor,
                        alignment: Alignment.centerRight,
                        child: Text('delete'.tr,
                                style: Theme.of(context).textTheme.bodyMedium)
                            .paddingSymmetric(horizontal: 20.w),
                      ),
                      child: _callView(
                          context, controller.missedCallsList[index],
                          isMissedCall: true),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(),
                  ).paddingSymmetric(vertical: 10.h)
                : const EmptyStateWidget().paddingSymmetric(vertical: 120.h),
      );

  _callView(context, CallHistoryData callData, {isMissedCall = false}) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        child: Row(
          children: [
            NetworkImageWidget(
              imageUrl: '',
              imageHeight: 40.h,
              imageWidth: 40.h,
              radiusAll: 40.h,
              placeHolder: AppImages.iconDummyProfile,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '@${controller.user.value?.sId == callData.caller?.id ? (callData.reciever?.userId ?? '') : (callData.caller?.userId ?? '')}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(
                          isMissedCall
                              ? 'missed'.tr
                              : (callData.status == AppConsts.rejected
                                  ? 'rejected'.tr
                                  : controller.user.value?.sId ==
                                          callData.caller?.id
                                      ? 'outgoing'.tr
                                      : 'incoming'.tr),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 10.sp))
                      .paddingOnly(top: 3.h),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(controller.formatCallTime(callData.time!.toLocal()),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 10.sp)),
            Inkwell(
              onTap: () {
                controller.getCallDetail(callData.id);
                _callDetailBottomSheet(context, callData,
                    isMissedCall: isMissedCall);
              },
              child: Image.asset(
                AppImages.iconInformation,
                height: 14.h,
              ).paddingOnly(left: 15.w, right: 5.w, top: 10.h, bottom: 10.h),
            ),
          ],
        ),
      );

  _callDetailBottomSheet(context, CallHistoryData callData,
          {isMissedCall = false}) =>
      CommonBottomSheetBackground.show(
          content: Obx(()=> Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '@${controller.user.value?.sId == callData.caller?.id ? (callData.reciever?.userId ?? '') : (callData.caller?.userId ?? '')}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.kPrimaryColor),
                      ),
                    ),
                    Inkwell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        AppImages.iconClose,
                        height: 12.h,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ).paddingOnly(top: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        isMissedCall
                            ? 'missed'.tr
                            : (callData.status == AppConsts.rejected
                                ? 'rejected'.tr
                                : controller.user.value?.sId ==
                                        callData.caller?.id
                                    ? 'outgoing'.tr
                                    : 'incoming'.tr),
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                        DateFormat('dd/MM/yyyy')
                                .format(callData.time!.toLocal()) ??
                            '',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ).paddingOnly(top: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        callData.status == AppConsts.notAnswered
                            ? 'Not Answered'
                            : callData.endedAt
                                        ?.difference(callData.time!)
                                        .inSeconds
                                        .toString() !=
                                    null
                                ? controller.convertSecondsToHHMMSS(callData
                                    .endedAt!
                                    .difference(callData.startAt!)
                                    .inSeconds)
                                : '',
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                        DateFormat('hh:mm a').format(callData.time!.toLocal()) ??
                            '',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ).paddingOnly(top: 10.h),
                _callSlider(context),
                CustomButton(
                    text: (controller.callDetail.value.isBlockedUser ?? false)
                        ? 'unblock'.tr
                        : 'block'.tr,
                    onPressed: () {
                      _sureToBlockBottomSheet(context,
                          userId: controller.user.value?.sId ==
                                  controller.callDetail.value.caller?.id
                              ? (controller.callDetail.value.reciever?.id ?? '')
                              : (controller.callDetail.value.caller?.id ?? ''),
                          blockStatus:
                              (controller.callDetail.value.isBlockedUser ?? false)
                                  ? AppConsts.unblock
                                  : AppConsts.block);
                    }).paddingOnly(bottom: 40.h)
              ],
            ),
          ),
          topMargin: 6.h,
          isDismissible: false);

  _callSlider(context) => Obx(
        () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: (controller.callingStarted.value) == true
                    ? Center(
                        child: SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: SizedBox(
                            height: 40.h,
                            child: const CircularProgressIndicator(
                                    color: AppColors.kPrimaryColor)
                                .paddingSymmetric(
                                    horizontal: 15.w, vertical: 15.h)),
                      ))
                    : SliderButton(
                        action: () async {
                          controller.callingStarted.value = true;
                          controller.startCall(
                              receiverId: controller.user.value?.sId ==
                                      controller.callDetail.value.caller?.id
                                  ? (controller.callDetail.value.reciever?.id ??
                                      '')
                                  : (controller.callDetail.value.caller?.id ??
                                      ''),
                              vehicleId:
                                  controller.callDetail.value.vehicle?.id);
                          return controller.callingStarted.value;
                        },
                        label: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Call",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            WidgetSpan(
                                child: SizedBox(
                              width: Get.width * 0.2,
                            )),
                            TextSpan(
                              text: ">",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white12),
                            ),
                            TextSpan(
                              text: ">",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.white38),
                            ),
                            TextSpan(
                              text: ">",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(color: Colors.white70),
                            ),
                            WidgetSpan(
                                child: SizedBox(
                              width: Get.width * 0.05,
                            )),
                          ]),
                        ),
                        icon: Image.asset(AppImages.iconCall),
                        width: Get.width * 0.7,
                        radius: 15.r,
                        height: 50.h,
                        buttonWidth: 50.w,
                        buttonSize: 50.w,
                        alignLabel: Alignment.centerRight,
                        buttonColor: AppColors.kPrimaryColor,
                        backgroundColor:
                            AppColors.whiteShadeBgColor.withOpacity(0.1),
                        highlightedColor: Colors.white,
                        baseColor: AppColors.kPrimaryColor,
                      ))
            .paddingSymmetric(vertical: 20.h),
      );

  _sureToBlockBottomSheet(context, {userId, blockStatus}) =>
      CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Text('sure_to_block'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      text: 'yes'.tr,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        controller.blockUnblockUser(
                          blockStatus: blockStatus,
                          userId: userId,
                        );
                        Get.back();
                      })),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                  child: CustomButton(
                      text: 'no'.tr,
                      borderColor: AppColors.kPrimaryColor,
                      textColor: AppColors.kPrimaryColor,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        Get.back();
                      }))
            ],
          ).paddingOnly(top: 15.h, bottom: 8.h)
        ],
      ));
}
