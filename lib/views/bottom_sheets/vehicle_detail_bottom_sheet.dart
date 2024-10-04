import 'package:scan_me_plus/export.dart';

class VehicleDetailBottomSheetContent extends StatelessWidget {
  final String userName;
  final String userId;
  final String vehicleId;
  final String vehicleImage;
  final String vehicleBrandImage;
  final String vehicleBrand;
  final String vehicleModel;
  final String vehicleNumber;
  final bool isBlockEnable;
  final bool? blockStatus;
  final bool? isFromHome;
  final bool isOwnVehicle;
  final RxBool? isCalling;
  final VoidCallback? onCrossPress;
  final Future<bool?> Function()? onCallStart;
  final VoidCallback? onBlockPress;
  final VoidCallback? onEmergencyAlertPress;

  const VehicleDetailBottomSheetContent({
    super.key,
    required this.userName,
    this.onBlockPress,
    this.onCrossPress,
    this.isCalling,
    required this.userId,
    required this.vehicleId,
    required this.vehicleImage,
    required this.vehicleBrandImage,
    this.onCallStart,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleNumber,
    this.isBlockEnable = true,
    this.isOwnVehicle = false,
    this.blockStatus,
    this.isFromHome,
    this.onEmergencyAlertPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _userName(context),
        NetworkImageWidget(
          imageUrl: vehicleImage,
          imageHeight: 110.h,
          imageWidth: Get.width * 0.6,
        ).paddingOnly(top: 20.h),
        _carDetail(context),
        isOwnVehicle
            ? Text(
                'This is your own vehicle.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ).paddingOnly(bottom: 30.h, top: 10.h)
            : const SizedBox(),
        if (isOwnVehicle) const SizedBox() else Column(
                children: [
                  _alertsList(),
                  CustomButton(
                      text: 'send'.tr,
                      isLoading: Get.find<MainController>().sendingAlert,
                      onPressed: () {
                        var index = Get.find<MainController>()
                            .emergencyAlerts
                            .indexWhere(
                                (element) => element.isSelected == true);
                        if (index != -1) {
                          Get.find<MainController>().sendEmergencyAlerts(
                              context,
                              userId: userId,
                              vehicleId: vehicleId,
                              emergencyAlert: Get.find<MainController>()
                                  .emergencyAlerts[index]
                                  .id);
                        } else {
                          AppAlerts.alert(
                              message: 'Select emergency alert to be send...');
                        }
                      }).paddingOnly(bottom: 30.h, top: 20.h, left: 10.w, right: 10.w)
                ],
              ),
        isOwnVehicle
            ? const SizedBox()
            : isBlockEnable == false
                ? _callSlider(context)
                : CustomButton(
                        text:
                            (blockStatus ?? false) ? 'unblock'.tr : 'block'.tr,
                        onPressed: onBlockPress ?? () {})
                    .paddingOnly(bottom: 40.h),
        isOwnVehicle
            ? const SizedBox()
            : isBlockEnable == false
                ? isFromHome != true ? Inkwell(
                    onTap: onCrossPress ??
                        () {
                          Get.back();
                        },
                    child: Text(
                      'rescan'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.kPrimaryColor),
                    ).paddingOnly(top: 15.h, bottom: 25.h),
                  )
                : SizedBox(
          height: 25.h,
        ): SizedBox(
          height: 25.h,
        ),
      ],
    );
  }

  _userName(context) => Row(
        children: [
          Expanded(
            child: Text(
              userName,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: AppColors.kPrimaryColor),
            ),
          ),
          Inkwell(
            onTap: onCrossPress ??
                () {
                  Get.back();
                },
            child: Image.asset(
              AppImages.iconClose,
              height: 12.h,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      );

  _carDetail(context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r)),
            child: NetworkImageWidget(
              imageUrl: vehicleBrandImage,
              imageHeight: 20.h,
              imageWidth: 30.h,
            ).paddingSymmetric(horizontal: 8.w, vertical: 15.h),
          ).paddingOnly(right: 10.w),
          Flexible(
              child: Text(
            '$vehicleBrand $vehicleModel \n$vehicleNumber',
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ))
        ],
      ).paddingSymmetric(vertical: 18.h);

  _alertsList() => Obx(()=> Get.find<MainController>().alertsLoading.value
        ? const CommonProgressBar().paddingSymmetric(vertical: 40.h)
        : Get.find<MainController>().emergencyAlerts.isNotEmpty
            ? ListView.builder(
                itemCount: Get.find<MainController>().emergencyAlerts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => Row(
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                          value: Get.find<MainController>()
                              .emergencyAlerts[index]
                              .isSelected,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.kPrimaryColor;
                            }
                            return AppColors.unSelectedColor;
                          }),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r)),
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -2),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                              color: Get.find<MainController>()
                                      .emergencyAlerts[index]
                                      .isSelected
                                  ? AppColors.kPrimaryColor
                                  : AppColors.unSelectedColor,
                              strokeAlign: 0,
                              width: 5,
                            ),
                          ),
                          checkColor: Colors.white,
                          onChanged: (value) {
                            Get.find<MainController>()
                                .emergencyAlerts
                                .forEach((element) {
                              if (element.id ==
                                  Get.find<MainController>()
                                      .emergencyAlerts[index]
                                      .id) {
                                element.isSelected = true;
                              } else {
                                element.isSelected = false;
                              }
                            });
                            Get.find<MainController>().emergencyAlerts.refresh();
                          }).paddingOnly(right: 2.w),
                    ),
                    Expanded(
                        child: Text(
                      Get.find<MainController>().emergencyAlerts[index].name ??
                          '',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
                  ],
                ),
              )
            : const EmptyStateWidget().paddingSymmetric(vertical: 40.h),
  );

  _callSlider(context) => Obx(() => AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: (isCalling?.value ?? false) == true
          ? Center(
              child: SizedBox(
              height: 50.h,
              width: 50.w,
              child: SizedBox(
                  height: 40.h,
                  child: const CircularProgressIndicator(
                          color: AppColors.kPrimaryColor)
                      .paddingSymmetric(horizontal: 15.w, vertical: 15.h)),
            ))
          : SliderButton(
              action: onCallStart ??
                  () async {
                    return null;
                  },
              label: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Call",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  WidgetSpan(
                      child: SizedBox(
                    width: Get.width * 0.2,
                  )),
                  TextSpan(
                    text: ">",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white12),
                  ),
                  TextSpan(
                    text: ">",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.white38),
                  ),
                  TextSpan(
                    text: ">",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white70),
                  ),
                  WidgetSpan(
                      child: SizedBox(
                    width: Get.width * 0.05,
                  )),
                ]),
              ),
              icon: Image.asset(AppImages.iconCall),
              width: Get.width * 0.7,
              radius: 15.r,
              height: 50.h,
              buttonWidth: 50.w,
              buttonSize: 50.w,
              alignLabel: Alignment.centerRight,
              buttonColor: AppColors.kPrimaryColor,
              backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
              highlightedColor: Colors.white,
              baseColor: AppColors.kPrimaryColor,
            )));
}
