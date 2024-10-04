import 'package:scan_me_plus/export.dart';

class MyPlansScreen extends GetView<MyPlansController> {
  const MyPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'my_plans'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: Obx(
        () => controller.planDataLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.planDetailData.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _activePlansHeading(context),
                      _activePlan(context),
                      controller.planExpired.value
                          ? Text('Note:- ${controller.activePlan.value.name} has been expired on ${controller.activePlan.value.userSubscription!.currentEnd != null ? ' ${DateFormat('dd/MM/yyyy').format(controller.activePlan.value.userSubscription!.currentEnd!)}.' : ''}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.redColor))
                              .paddingOnly(bottom: 15.h)
                          : controller.planCancelled.value
                              ? Text('Note:- ${controller.activePlan.value.name} has been cancelled${controller.activePlan.value.userSubscription!.currentEnd != null ? ' and will be active till ${DateFormat('dd/MM/yyyy').format(controller.activePlan.value.userSubscription!.currentEnd!)}.' : ''}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: AppColors.redColor))
                                  .paddingOnly(bottom: 15.h)
                              : const SizedBox(),
                      controller.upcomingPlan.value.id != null
                          ? _upcomingPlanHeading(context)
                          : const SizedBox(),
                      controller.upcomingPlan.value.id != null
                          ? _upcomingPlan(context)
                          : const SizedBox(),
                      controller.upgradePlans.isNotEmpty
                          ? Text('membership_plans'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: AppColors.kPrimaryColor))
                          : Container(),
                      _membershipPlans(context),
                      Text('billing_details'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColors.kPrimaryColor)),
                      _billingDetails(context)
                    ],
                  ).paddingSymmetric(vertical: 20.h, horizontal: 15.w))
                : const EmptyStateWidget().paddingSymmetric(vertical: 110.h),
      ),
    );
  }

  _activePlansHeading(context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              controller.planExpired.value
                  ? 'expired_plan'.tr
                  : 'active_plan'.tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: controller.planExpired.value
                      ? AppColors.redColor
                      : AppColors.kPrimaryColor)),
          Inkwell(
            onTap: () {
              controller.downloadInvoice();
            },
            child: Text('download_invoice'.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(decoration: TextDecoration.underline)),
          )
        ],
      );

  _activePlan(context) => Column(
        children: [
          _activePlanPriceDate(context),
          _activePlanFeatures(context),
        ],
      ).paddingSymmetric(vertical: 15.h);

  _activePlanPriceDate(context) => Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.activePlan.value.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  Text('${'inr'.tr}${controller.activePlan.value.amount ?? ''}',
                      style: Theme.of(context).textTheme.headlineLarge)
                ],
              ),
              Text(
                  '${controller.planCancelled.value ? 'Plan End Date' : 'next_billing_date'.tr} - ${controller.activePlan.value.userSubscription?.currentEnd != null ? DateFormat('dd/MM/yyyy').format(controller.activePlan.value.userSubscription!.currentEnd!) : ''}',
                  style: Theme.of(context).textTheme.bodySmall),
              controller.planExpired.value
                  ? _renewPlanButton(context)
                  : controller.planCancelled.value
                      ? const SizedBox()
                      : _cancelPlanButton(context),
            ],
          ),
        ),
      );

  _activePlanFeatures(context) => Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: AppColors.whiteShadeBgColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(12.r),
          )),
      child: Obx(
        () => Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 5.h),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.isShowMore.value == false
                  ? 3
                  : controller.activePlan.value.features?.length ?? 0,
              itemBuilder: (BuildContext context, int index) => Row(
                children: [
                  Text(
                    '• ',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 20.h, height: 1.1),
                  ),
                  Text(
                    controller.activePlan.value.features?[index] ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Inkwell(
              onTap: () {
                controller.isShowMore.value = !controller.isShowMore.value;
              },
              child: Text(
                  controller.isShowMore.value == true
                      ? 'show_less'.tr
                      : 'show_more'.tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.kPrimaryColor,
                      color: AppColors.kPrimaryColor)),
            )
          ],
        ),
      ));

  _upcomingPlanHeading(context) => Text('upcoming_plan'.tr,
      style: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(color: AppColors.kPrimaryColor));

  _upcomingPlan(context) => Obx(
        () => Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.upcomingPlan.value.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  Text(
                      '${'inr'.tr}${controller.upcomingPlan.value.amount ?? ''}',
                      style: Theme.of(context).textTheme.headlineLarge)
                ],
              ),
              Text(
                  '${'Plan Start Date'.tr} - ${controller.upcomingPlan.value.userSubscription?.startAt != null ? DateFormat('dd/MM/yyyy').format(controller.upcomingPlan.value.userSubscription!.startAt!) : ''}',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ).paddingSymmetric(vertical: 15.h);

  _membershipPlans(context) => controller.upgradePlans.isNotEmpty
      ? SizedBox(
          height: 151.h,
          child: ListView.separated(
            itemCount: controller.upgradePlans.length,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Obx(() =>
                Container(
                  width: Get.width * 0.435,
                  padding: EdgeInsets.only(
                      top: 10.h, bottom: 20.h, left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                      color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Column(
                    children: [
                      Text(
                        controller.upgradePlans[index].name ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).paddingOnly(top: 8.h),
                      Text(
                        '${'inr'.tr}${controller.upgradePlans[index].amount ?? ''}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).paddingSymmetric(vertical: 7.h),
                      CustomButton(
                              text: 'upgrade'.tr,
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              fontSize: 12.sp,
                              borderRadius: 8.r,
                              onPressed: controller.subscriptionLoading.value
                                  ? () {}
                                  : controller.upcomingPlan.value.id != null
                                      ? () {
                                          AppAlerts.alert(
                                              message:
                                                  'A plan is already in queue');
                                        }
                                      : () {
                                          _upgradePlanMessage(context,
                                              controller.upgradePlans[index]);
                                        })
                          .paddingOnly(bottom: 2.h)
                    ],
                  ),
                ).paddingSymmetric(vertical: 15.h)),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 15.w,
            ),
          ),
        )
      : Container();

  _upgradePlanMessage(context, MembershipPlansData upgradePlan) => Get.dialog(
        Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.all(20.h),
                margin: EdgeInsets.symmetric(horizontal: 15.h),
                decoration: BoxDecoration(
                    color: AppColors.splashBgColor,
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'The payment for the upgraded subscription plan will be deducted from your account once the current plan ends. The charge will be applied now.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              text: 'cancel'.tr,
                              borderColor: AppColors.kPrimaryColor,
                              textColor: AppColors.kPrimaryColor,
                              backgroundColor: Colors.transparent,
                              onPressed: () {
                                Get.back();
                              }),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: CustomButton(
                              text: 'upgrade'.tr,
                              isLoading: controller.subscriptionLoading,
                              onPressed: () {
                                controller.subscriptionUpgrade(upgradePlan);
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _billingDetails(context) =>
      controller.activePlan.value.userSubscription?.amountPaid != null &&
              controller.activePlan.value.userSubscription?.amountPaid != ''
          ? Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              decoration: BoxDecoration(
                  color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.activePlan.value.name ?? '',
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(
                              controller.activePlan.value.userSubscription
                                          ?.amountPaidAt !=
                                      null
                                  ? DateFormat('EEEE, dd/MM/yyyy').format(
                                      controller.activePlan.value
                                          .userSubscription!.amountPaidAt!)
                                  : '',
                              style: Theme.of(context).textTheme.bodyMedium)
                          .paddingSymmetric(vertical: 4.h),
                      Row(
                        children: [
                          // Image.asset(
                          //   AppImages.iconMasterCard,
                          //   height: 14.h,
                          // ),
                          Text(
                              /*'•••• •••• •••• 5896'*/ controller.activePlan
                                      .value.userSubscription?.paymentMethod
                                      .toString()
                                      .toUpperCase() ??
                                  '',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                  Text(
                      '${'inr'.tr}${controller.activePlan.value.userSubscription?.amountPaid ?? ''}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.kPrimaryColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ).paddingSymmetric(vertical: 15.h)
          : Container(
              alignment: Alignment.center,
              child: Text('Plan details will be updated soon..'.tr,
                      style: Theme.of(context).textTheme.bodyMedium)
                  .paddingSymmetric(vertical: 30.h),
            );

  _renewPlanButton(context) => Align(
        alignment: Alignment.centerRight,
        child: Inkwell(
          onTap: controller.renewPlanLoading.value ? (){} : () {
            controller.renewSubscriptionPlan(controller.activePlan.value);
          },
          child: Text('renew'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.redColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.w,
                  decorationColor: AppColors.redColor)),
        ),
      );

  _cancelPlanButton(context) => Align(
        alignment: Alignment.centerRight,
        child: Inkwell(
          onTap: () {
            CommonBottomSheetBackground.show(
                content: Column(
              children: [
                Text(
                  'sure_to_cancel_plan'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ).paddingOnly(bottom: 10.h),
                CustomButton(
                  text: 'cancel_plan'.tr,
                  isLoading: controller.cancelPlanLoading,
                  onPressed: () {
                    controller.cancelSubscriptionPlan(
                        id: controller.activePlan.value.userSubscription?.id);
                  },
                ).paddingSymmetric(vertical: 10.h)
              ],
            ));
          },
          child: Text('cancel_plan'.tr,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.redColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.w,
                  decorationColor: AppColors.redColor)),
        ),
      );
}
