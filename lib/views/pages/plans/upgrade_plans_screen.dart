import 'package:scan_me_plus/export.dart';

class UpgradePlansScreen extends GetView<UpgradePlansController> {
  const UpgradePlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'plans'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
          onBackPress: () {
          Get.offAllNamed(AppRoutes.routeHome);
          }
      ),
      body: Obx( () => controller.isLoading.value
          ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
          : controller.subscriptionPlansList.isNotEmpty
          ? SingleChildScrollView(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _plansDataList(context),
                  _plansList(),
                ],
              ),
            ),
            _upgradeButton()
                    ],
                  ).paddingSymmetric(horizontal: 15.w, vertical: 20.h),
          ) : const EmptyStateWidget().paddingSymmetric(vertical: 120.h)),
    );
  }

  _plansDataList(context) =>
      Obx(() => controller.selectedMembershipPlan.value.id != null
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'whats_included'.tr,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.kPrimaryColor),
                    ),
                    Text(
                      'premium'.tr,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.kPrimaryColor),
                    ),
                  ],
                ).paddingOnly(bottom: 10.h),
                ListView.builder(
                  itemCount:
                      controller.selectedMembershipPlan.value.features?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => _plansData(
                      context,
                      title: controller
                          .selectedMembershipPlan.value.features![index]),
                ),
              ],
            )
          : const SizedBox());

  _plansData(context, {title}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(
              AppImages.iconTick,
              height: 15.h,
            ),
          )
        ],
      ).paddingSymmetric(vertical: 5.h);

  _plansList() => Obx(
        () => ListView.separated(
          itemCount: controller.subscriptionPlansList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Container(
            decoration: BoxDecoration(
                color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r)),
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.subscriptionPlansList[index].name ?? '',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      controller.subscriptionPlansList[index].description ?? '',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppColors.kPrimaryColor),
                    ),
                  ],
                ),
                Checkbox(
                    value: controller.subscriptionPlansList[index].isSelected,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    activeColor: AppColors.kPrimaryColor,
                    checkColor: Colors.white,
                    onChanged: (value) {
                      if (controller.subscriptionPlansList[index].isSelected ==
                          false) {
                        for (var element in controller.subscriptionPlansList) {
                          if (element.id ==
                              controller.subscriptionPlansList[index].id) {
                            element.isSelected = true;
                          } else {
                            element.isSelected = false;
                          }
                        }
                        controller.selectedMembershipPlan.value =
                            controller.subscriptionPlansList[index];
                      }
                      controller.subscriptionPlansList.refresh();
                    })
              ],
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 12.h,
          ),
        ).paddingSymmetric(vertical: 15.h),
      );

  _upgradeButton() => CustomButton(
      text: 'upgrade_to_premium'.tr,
      isLoading: controller.subscriptionLoading,
      onPressed: () {
        if(controller.selectedMembershipPlan.value.id != null){
          controller.subscriptionPurchase();
        }
      }).paddingOnly(bottom: 20.h);
}
