import 'package:scan_me_plus/export.dart';

class PurchaseListScreen extends GetView<PurchaseListController> {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          isLeadingVisible: false,
          title: 'purchase_list'.tr,
          backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
              : controller.myVehiclesList.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () async {
                          if( controller.myVehiclesList[index].isSubscribed == false){
                            _purchasePlanBottomSheet(context, index);
                          }
                          else if (controller.myVehiclesList[index].isSubscribed ==
                                  true ||
                              controller.myVehiclesList[index].isExpired ==
                                  true) {
                            var data = await Get.toNamed(AppRoutes.routeMyPlans,
                                arguments: {
                                  'vehicleId':
                                      controller.myVehiclesList[index].id
                                });
                            if (data != null) {
                              controller.getMyVehicleList();
                            }
                          } else {
                            _purchasePlanBottomSheet(context, index);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  AppColors.whiteShadeBgColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Row(
                            children: [
                              NetworkImageWidget(
                                imageUrl: controller.myVehiclesList[index]
                                        .vehicleModel?.image ??
                                    '',
                                imageHeight: 65.h,
                                imageWidth: 70.h,
                                imageFitType: BoxFit.fitWidth,
                              ).paddingOnly(right: 15.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.myVehiclesList[index].vehicleBrand?.name} ${controller.myVehiclesList[index].vehicleModel?.name} ${controller.myVehiclesList[index].vehicleNumber}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ).paddingOnly(bottom: 5.h),
                                    if (controller.myVehiclesList[index]
                                            .isSubscribed ??
                                        false)
                                      Text(
                                        '₹${controller.myVehiclesList[index].subscription?.plan?.amount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                color: AppColors.kPrimaryColor),
                                      )
                                    else
                                      const SizedBox(),
                                  ],
                                ),
                              ),
                              Image.asset(
                                AppImages.iconArrowRight,
                                height: 10.h,
                              ).paddingOnly(left: 15.w),
                            ],
                          ).paddingSymmetric(vertical: 5.h, horizontal: 15.w),
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 10.h,
                      ),
                      itemCount: controller.myVehiclesList.length,
                    ).paddingSymmetric(vertical: 20.h, horizontal: 15.w)
                  : const EmptyStateWidget(),
        ));
  }

  _purchasePlanBottomSheet(context, index) => CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Text(
            'subscription_not_purchased'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ).paddingOnly(bottom: 10.h),
          CustomButton(
            text: 'purchase_plan'.tr,
            onPressed: () {
              Get.toNamed(AppRoutes.routeUpgradePlans, arguments: {
                'vehicleId': controller.myVehiclesList[index].id
              });
            },
          ).paddingSymmetric(vertical: 10.h)
        ],
      ));
}
