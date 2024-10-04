import 'package:scan_me_plus/export.dart';

class MyProfileScreen extends GetView<MyProfileController> {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        isLeadingVisible: false,
        title: 'my_profile'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileDetail(context),
          Divider(
            color: Colors.white12,
            thickness: 1.5.h,
          ),
          _accountHeading(context),
          _accountItemsList(context)
        ],
      ),
    );
  }

  _profileDetail(context) => Obx(
        () => Row(
          children: [
            NetworkImageWidget(
                imageUrl: controller.user.value?.image ?? '',
                imageHeight: 60.h,
                imageWidth: 60.h,
                radiusAll: 100.r,
                imageFitType: BoxFit.fill,
                placeHolderWidget: Container(
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.user.value?.userId?.split('').first.toUpperCase() ??
                        '',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                )).paddingOnly(right: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user.value?.email != null &&
                            controller.user.value?.email != ''
                        ? 'Hi, ${controller.user.value?.firstName ?? ''} ${controller.user.value?.lastName ?? ''}'
                        : 'Hi',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).paddingOnly(bottom: 2.h),
                  controller.user.value?.email != null &&
                          controller.user.value?.email != ''
                      ? Text(
                          controller.user.value?.email ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      : Inkwell(
                          onTap: () => Get.toNamed(
                              AppRoutes.routeAddProfileDetails,
                              arguments: {
                                'from_home': true,
                              }),
                          child: Text(
                            'add_profile_details'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.kPrimaryColor),
                          ),
                        ),
                ],
              ),
            ),
            Inkwell(
              onTap: () {
                Get.toNamed(AppRoutes.routeEditProfileDetails);
              },
              child: Image.asset(
                AppImages.iconEdit,
                height: 13.h,
              ).paddingOnly(left: 10.w),
            )
          ],
        ).paddingOnly(left: 15.w, right: 15.w, top: 20.h, bottom: 12.h),
      );

  _accountHeading(context) => Text(
        'account'.tr,
        style: Theme.of(context).textTheme.headlineMedium,
      ).paddingSymmetric(vertical: 12.h, horizontal: 15.w);

  _accountItemsList(context) => ListView.separated(
        itemCount: controller.accountItemsList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => Inkwell(
          onTap: () {
            switch (index) {
              case 0:
                Get.toNamed(AppRoutes.routeReferFriend);
                break;
              case 1:
                Get.toNamed(AppRoutes.routeSocietyHotelSignup);
                break;
              case 2:
                Get.toNamed(AppRoutes.routeAbout);
                break;
              case 3:
                Get.toNamed(AppRoutes.routeHelpSupport);
                break;
              case 4:
                _deleteAccountBottomSheet(context);
                break;
              case 5:
                _logoutBottomSheet(context);
                break;
            }
          },
          child: Row(
            children: [
              Image.asset(
                controller.accountItemsList[index].icon,
                height: 18.h,
                color: AppColors.kPrimaryColor,
              ).paddingOnly(right: 20.w),
              Expanded(
                  child: Text(
                controller.accountItemsList[index].text.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 13.5.sp),
              )),
              Image.asset(
                AppImages.iconArrowRight,
                height: 10.h,
                color: AppColors.kPrimaryColor,
              ).paddingOnly(left: 20.w)
            ],
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.white12,
          thickness: 1.h,
        ).paddingSymmetric(vertical: 12.h),
      ).paddingSymmetric(horizontal: 15.w, vertical: 8.h);

  _deleteAccountBottomSheet(context) => CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Text(
            'sure_delete'.tr,
            style: Theme.of(context).textTheme.labelLarge,
          ).paddingOnly(bottom: 20.h),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      text: 'yes'.tr,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        controller.deleteAccount();
                        Get.offAllNamed(AppRoutes.routeLogin);
                      })),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: CustomButton(
                    text: 'no'.tr,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kPrimaryColor,
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ],
          )
        ],
      ));

  _logoutBottomSheet(context) => CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Text(
            'sure_logout'.tr,
            style: Theme.of(context).textTheme.labelLarge,
          ).paddingOnly(bottom: 20.h),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      text: 'yes'.tr,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        controller.updateFcmToken();
                        Get.offAllNamed(AppRoutes.routeLogin);
                      })),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: CustomButton(
                    text: 'no'.tr,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    backgroundColor: Colors.transparent,
                    borderColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kPrimaryColor,
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ],
          )
        ],
      ));
}
