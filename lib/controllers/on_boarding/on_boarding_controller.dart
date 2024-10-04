import 'package:scan_me_plus/export.dart';

class OnBoardingController extends GetxController {
  RxList<OnBoardingScreenData> onBoardingData = <OnBoardingScreenData>[
    OnBoardingScreenData(
        image: AppImages.imgOnBoarding1, text: 'on_boarding_text1'.tr),
    OnBoardingScreenData(
        image: AppImages.imgOnBoarding2, text: 'on_boarding_text2'.tr),
    OnBoardingScreenData(
        image: AppImages.imgOnBoarding3, text: 'on_boarding_text3'.tr),
  ].obs;

  PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  nextPage() {
    if (currentPage < onBoardingData.length - 1) {
      currentPage.value++;
      pageController.animateToPage(currentPage.value,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }
}

class OnBoardingScreenData {
  String image;
  String text;

  OnBoardingScreenData({required this.image, required this.text});
}
