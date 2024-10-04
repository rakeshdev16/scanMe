import 'package:scan_me_plus/export.dart';

class SocietyHotelSignupScreen extends GetView<SocietyHotelSignupController> {
  const SocietyHotelSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'society_hotel_signup'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: Obx(
        () => Container(
            height: Get.height * 0.8,
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      controller.imagesList.value[0],
                      height: 50.h,
                      color: Colors.white,
                    ),
                    Image.asset(
                      controller.imagesList.value[1],
                      height: 50.h,
                      color: Colors.white,
                    ),
                    Image.asset(
                      controller.imagesList.value[2],
                      height: 50.h,
                      color: Colors.white,
                    ),
                    Image.asset(
                      controller.imagesList.value[3],
                      height: 50.h,
                      color: Colors.white,
                    )
                  ],
                ).paddingOnly(top: 40.h),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      AppImages.iconComingSoon,
                      height: 150.h,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  /*Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: Get.height *0.5,
                width: Get.width,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  controller.imagesList.value[0],
                  height: 50.h,
                  color: Colors.white,
                ).paddingOnly(top: 20.h, left: 30.h),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  controller.imagesList.value[1],
                  height: 50.h,
                  color: Colors.white,
                ).paddingOnly(top: 20.h, right: 30.h),
              ),
              Image.asset(
                AppImages.iconComingSoon,
                height: 150.h,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  controller.imagesList.value[2],
                  height: 50.h,
                  color: Colors.white,
                ).paddingOnly(bottom: 10.h, left: 40.h),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  controller.imagesList.value[3],
                  height: 50.h,
                  color: Colors.white,
                ).paddingOnly(bottom: 10.h, right: 35.h),
              ),
            ],
          ),*/
}
