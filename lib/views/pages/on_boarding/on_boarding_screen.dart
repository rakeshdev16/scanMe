import 'package:scan_me_plus/export.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBgColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [_pageView(), _skipNextButton(context)],
      ),
    );
  }

  _pageView() => PageView.builder(
        controller: controller.pageController,
        itemCount: controller.onBoardingData.length,
        itemBuilder: (BuildContext context, int index) => Stack(
          children: [
            Image.asset(
              controller.onBoardingData[index].image,
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Positioned(
                bottom: index == 1 ? 0.w : 190.w,
                left: 20.w,
                right: 20.w,
                top: index == 1 ? 150.w : null,
                child: Text(
                  controller.onBoardingData[index].text,
                  style: Theme.of(context).textTheme.displayMedium,
                )),
          ],
        ),
        onPageChanged: (page) {
          controller.currentPage.value = page;
        },
      );

  _pageIndicator() => SmoothPageIndicator(
        controller: controller.pageController,
        count: controller.onBoardingData.length,
        axisDirection: Axis.horizontal,
        effect: ExpandingDotsEffect(
            activeDotColor: AppColors.kPrimaryColor,
            dotColor: AppColors.unSelectedColor,
            expansionFactor: 1.7,
            dotHeight: 5.h,
            dotWidth: 20.h,
            spacing: 4.w,
            radius: 44.r),
      );

  _skipNextButton(context) => Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: controller.currentPage.value < 2,
              child: Inkwell(
                onTap: () {
                  PreferenceManager.isFirstLaunch = true;
                  Get.offNamed(AppRoutes.routeLogin);
                },
                child: Text(
                  'skip'.tr,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _pageIndicator(),
                Inkwell(
                  onTap: () {
                    if (controller.currentPage.value == 2) {
                      PreferenceManager.isFirstLaunch = true;
                      Get.offNamed(AppRoutes.routeLogin);
                    } else {
                      controller.nextPage();
                    }
                  },
                  child: Text(
                    controller.currentPage.value == 2
                        ? 'get_started'.tr
                        : 'next'.tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            )
          ],
        ).paddingOnly(left: 20.w, right: 20.w, bottom: 25.w, top: 35.w),
      );
}
