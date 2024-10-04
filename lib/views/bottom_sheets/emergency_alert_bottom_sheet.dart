import 'package:scan_me_plus/export.dart';

class EmergencyAlertBottomSheetContent extends StatelessWidget {
  final String vehicleId;
  final String userId;

  const EmergencyAlertBottomSheetContent({
    super.key,
    required this.vehicleId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'emergency_alert'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.kPrimaryColor),
                ),
              ),
              Inkwell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImages.iconClose,
                  height: 12.h,
                  color: Colors.grey.shade300,
                ),
              ),
            ],
          ).paddingOnly(bottom: 10.h),

        ],
      ),
    );
  }


}
