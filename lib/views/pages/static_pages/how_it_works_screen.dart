import 'package:scan_me_plus/export.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          title: 'how_it_works'.tr,
          backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        ),
      body: Column(
        children: [
          _howItWorksData(context, icon: AppImages.iconShare, text: 'share'.tr),
          _howItWorksData(context,
              icon: AppImages.iconDownload, text: 'download'.tr),
          _howItWorksData(context,
              icon: AppImages.iconExperience, text: 'experience'.tr)
        ],
      ).paddingSymmetric(horizontal: 15.w, vertical: 20.h),
    );
  }

  _howItWorksData(context, {icon, text}) => Row(
    children: [
      Image.asset(
        icon,
        height: 36.h,
      ).paddingOnly(right: 18.w),
      Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodySmall))
    ],
  ).paddingSymmetric(vertical: 8.h);
}
