
import 'package:scan_me_plus/export.dart';

class NotificationAlertScreen extends GetView<NotificationAlertController> {
  const NotificationAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RippleAnimation(
              repeat: true,
              color: AppColors.kPrimaryColor,
              minRadius: 50,
              ripplesCount: 6,
              child: Image.asset(
                AppImages.iconAlert,
                height: 80.h,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Obx(
                () => Text(
                  controller.alert.value,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            Inkwell(
              onTap: () {
                // if(Platform.isAndroid){
                //   FlutterOverlayWindow.closeOverlay()
                //       .then((value) => debugPrint('STOPPED: alue: $value'));
                // }else{
                Get.offAllNamed(AppRoutes.routeHome);
                // }
              },
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.kPrimaryColor),
                child: Text(
                  'ok'.tr,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge,
                ).paddingAll(25.h),
              ),
            )
          ],
        ).paddingSymmetric(vertical: 20.h, horizontal: 15.w),
      ),
    );
  }
}
