import 'package:scan_me_plus/export.dart';

class StaticPageScreen extends GetView<StaticPageController> {
  const StaticPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        appBar: CustomAppBar(
            title: controller.pageHeading.value,
          backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        ),
        body: controller.isLoading.value == true
            ? const Center(child: CommonProgressBar())
            : controller.staticPageData.value.content != null &&
                    controller.staticPageData.value.content != ''
                ? SingleChildScrollView(
                    child: RichText(
                    text: HTML.toTextSpan(
                      context,
                      controller.staticPageData.value.content!,
                      linksCallback: (dynamic link) {
                        launchUrl(Uri.parse(link));
                      },
                      defaultTextStyle: TextStyle(
                          color: AppColors.colorTextPrimary,
                          fontSize: 14.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none),
                      overrideStyle: <String, TextStyle>{
                        "p": TextStyle(
                            color: AppColors.colorTextPrimary,
                            fontSize: 14.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none)
                      },
                    ),
                    textAlign: TextAlign.justify,
                  ).paddingSymmetric(horizontal: 20.h, vertical: 15.w))
                : Center(
                    child: Text(
                      'Data will be available soon '.tr,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  )));
  }
}
