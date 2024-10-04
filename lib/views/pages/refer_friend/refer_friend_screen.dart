import 'package:scan_me_plus/export.dart';
import 'package:share_plus/share_plus.dart';

class ReferAFriendScreen extends GetView<ReferAFriendController> {
  const ReferAFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'refer_friend'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _referralLink(context),
          _howItWorks(context),
          _howItWorksData(context, icon: AppImages.iconShare, text: 'share'.tr),
          _howItWorksData(context,
              icon: AppImages.iconDownload, text: 'download'.tr),
          _howItWorksData(context,
              icon: AppImages.iconExperience, text: 'experience'.tr),
        ],
      ).paddingSymmetric(vertical: 20.h, horizontal: 15.w),
    );
  }

  _referralLink(context) => Container(
        decoration: BoxDecoration(
            color: AppColors.whiteShadeBgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'here_referral_link'.tr,
              style: Theme.of(context).textTheme.headlineMedium,
            ).paddingOnly(bottom: 10.h),
            _copyReferralLink(context),
            _inviteWhatsApp(context),
            Align(
              alignment: Alignment.center,
              child: Inkwell(
                onTap: () {
                  Share.share(
                      'check out my website https://scanmeadmin.vinnisoft.com/');
                },
                child: Text(
                  'other_share_options'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.kPrimaryColor),
                ),
              ),
            ),
          ],
        ).paddingSymmetric(vertical: 12.h, horizontal: 22.r),
      );

  _copyReferralLink(context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            border: Border.all(color: Colors.white, width: 0.5.h)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'https://www.google.com/',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(overflow: TextOverflow.ellipsis),
              ).paddingOnly(right: 10.w),
            ),
            Inkwell(
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(text: 'https://www.google.com/'));
                Get.closeAllSnackbars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to Clipboard!'),
                  backgroundColor: AppColors.kPrimaryColor.withOpacity(0.9),),
                );
              },
              child: Image.asset(
                AppImages.iconCopy,
                height: 17.h,
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 18.w, vertical: 7.h),
      );

  _inviteWhatsApp(context) => Inkwell(
        onTap: () async {
          navigateToWhatsApp();
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.circular(12.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.iconWhatsapp,
                height: 20.h,
              ).paddingOnly(right: 6.w),
              Text(
                'invite_whatsapp'.tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ).paddingSymmetric(horizontal: 15.w, vertical: 8.h),
        ).paddingOnly(top: 15.h, bottom: 10.h),
      );

  void navigateToWhatsApp() async {
    var whatsappUrl = 'whatsapp://send?text=https://www.google.com/';
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication);
    } else {
      navigateToWhatsAppInPlayStore();
    }
  }

  void navigateToWhatsAppInPlayStore() async {
    String whatsappUrl = Platform.isAndroid
        ? 'https://play.google.com/store/apps/details?id=com.whatsapp'
        : 'https://apps.apple.com/app/whatsapp-messenger/id310633997';
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  _howItWorks(context) => Text(
        'how_it_works'.tr,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 20.sp,
            ),
      ).paddingOnly(top: 15.h, bottom: 16.h);

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
