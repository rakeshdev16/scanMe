import 'package:scan_me_plus/export.dart';

class AboutController extends GetxController {
  RxList<AccountItems> aboutItemsList = <AccountItems>[
    AccountItems(icon: AppImages.iconHowWorks, text: 'how_it_works'.tr),
    AccountItems(icon: AppImages.iconPrivacyPolicy, text: 'privacy_policy'.tr),
    AccountItems(icon: AppImages.iconTermsCondition, text: 'terms_of_use'.tr),
  ].obs;
}
