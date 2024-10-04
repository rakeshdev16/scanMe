import 'package:scan_me_plus/export.dart';

class AboutScreen extends GetView<AboutController> {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          title: 'about'.tr,
          backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        ),
        body: ListView.separated(
          itemCount: controller.aboutItemsList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Inkwell(
            onTap: () {
              switch (index) {
                case 0:
                  Get.to(()=> const HowItWorksScreen());
                  break;
                case 1:
                  Get.toNamed(AppRoutes.routeStaticPage,
                      arguments: {'pageType': 'privacy_policy'.tr});
                  break;
                case 2:
                  Get.toNamed(AppRoutes.routeStaticPage,
                      arguments: {'pageType': 'terms_of_use'.tr});
                  break;
              }
            },
            child: Row(
              children: [
                Image.asset(
                  controller.aboutItemsList[index].icon,
                  height: 20.h,
                  color: AppColors.kPrimaryColor,
                ).paddingOnly(right: 20.w),
                Expanded(
                    child: Text(
                  controller.aboutItemsList[index].text.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                Image.asset(
                  AppImages.iconArrowRight,
                  height: 12.h,
                  color: AppColors.kPrimaryColor,
                ).paddingOnly(left: 20.w)
              ],
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.white12,
            thickness: 1.h,
          ).paddingSymmetric(vertical: 12.h),
        ).paddingSymmetric(horizontal: 15.w, vertical: 25.h));
  }
}
