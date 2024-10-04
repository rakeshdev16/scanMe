import 'package:scan_me_plus/export.dart';

class ThanksScreen extends GetView<ThanksController> {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          _thankyou(context),
          _proceedWithExecutiveButton(context),
          _shipToLocationButton(context)
        ],
      ).paddingSymmetric(horizontal: 15.w, vertical: 25.h),
    );
  }

  _thankyou(context) => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.iconThankYouCheck,
                    height: 80.h,
                  ).paddingOnly(bottom: 40.h),
                  Text('thankyou_for_choosing_us'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium).paddingOnly(bottom: 20.h),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 15.w),
      );

  _proceedWithExecutiveButton(context) => CustomButton(
      text: 'proceed_with_executive'.tr,
      borderColor: Colors.white,
      backgroundColor: Colors.transparent,
      onPressed: () {
        Get.offAllNamed(AppRoutes.routeHome);
      }).paddingOnly(bottom: 15.h);

  _shipToLocationButton(context) => CustomButton(
      text: 'ship_to_your_location'.tr,
      onPressed: () {
        _proceedWithShipmentBottomSheet(context);
      });

  _proceedWithShipmentBottomSheet(context) => CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Text('sure_ship_to_location'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      text: 'yes'.tr,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        Get.back();
                        Get.toNamed(AppRoutes.routeShippingAddress, arguments: {
                          'vehicleId' : controller.vehicleId.value
                        });
                      })),
              SizedBox(
                width: 15.h,
              ),
              Expanded(
                  child: CustomButton(
                      text: 'no'.tr,
                      borderColor: AppColors.kPrimaryColor,
                      textColor: AppColors.kPrimaryColor,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        Get.back();
                      }))
            ],
          ).paddingOnly(top: 15.h, bottom: 8.h)
        ],
      ));
}
