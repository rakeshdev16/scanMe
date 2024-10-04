import 'package:scan_me_plus/export.dart';

class ConfirmVehicleDetailScreen
    extends GetView<ConfirmVehicleDetailsController> {
  ConfirmVehicleDetailScreen({super.key});

  final GlobalKey<FormState> addVehicle = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        title: 'confirm_details'.tr,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: SizedBox(
            height: Get.height * 0.9,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _selectedBrand(context),
                    controller.viewDetail.value == true
                        ? _vehicleDetails()
                        : const SizedBox(),
                  ],
                ),
                _addVehicleButton()
              ],
            ).paddingSymmetric(horizontal: 15.w, vertical: 20.h),
          ),
        ),
      ),
    );
  }

  _selectedBrand(context) => Inkwell(
        onTap: () {
          controller.viewDetail.value = !controller.viewDetail.value;
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          decoration: BoxDecoration(
              color: AppColors.whiteShadeBgColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                decoration: BoxDecoration(
                    color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.r)),
                child: NetworkImageWidget(
                  imageUrl: controller.vehicleBrand.value.image ?? '',
                  imageHeight: 50.h,
                  imageWidth: 60.w,
                  imageFitType: BoxFit.contain,
                ),
              ).paddingOnly(right: 10.w),
              Expanded(
                child: Text(
                  '${controller.vehicleBrand.value.name ?? ''} \n${controller.vehicleModel.value.name ?? ''}',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Transform.rotate(
                angle: controller.viewDetail.value == false ? 45.55 : 42.42,
                child: Image.asset(
                  AppImages.iconArrowRight,
                  height: 10.h,
                ),
              )
            ],
          ).paddingSymmetric(vertical: 15.h),
        ),
      );

  _vehicleDetails() => Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
            color: AppColors.whiteShadeBgColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
        child: Form(
          key: addVehicle,
          child: Column(
            children: [
              CustomTextField(
                  label: 'brand'.tr,
                  isRequired: true,
                  isReadOnly: true,
                  controller: controller.brandTextController,
                  validator: (value) => FieldChecker.fieldChecker(
                      value: value, message: 'model'.tr),
                  focusNode: controller.brandFocusNode),
              CustomTextField(
                      label: 'model'.tr,
                      isRequired: true,
                      isReadOnly: true,
                      validator: (value) => FieldChecker.fieldChecker(
                          value: value, message: 'model'.tr),
                      controller: controller.modelTextController,
                      focusNode: controller.modelFocusNode)
                  .paddingSymmetric(vertical: 15.h),
              CustomTextField(
                  label: 'vehicle_number'.tr,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(' '),
                    UpperCaseTextFormatter()
                  ],
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) =>
                      VehicleNumberValidate.validateVehicle(value ?? ''),
                  controller: controller.vehicleNumberTextController,
                  focusNode: controller.vehicleNumberFocusNode),
            ],
          ),
        ),
      );

  _addVehicleButton() => CustomButton(
      text: 'add_vehicle'.tr,
      isLoading: controller.addVehicleLoading,
      isEnable: controller.viewDetail,
      onPressed: () {
        if (addVehicle.currentState!.validate()) {
          controller.addVehicle();
        }
      }).paddingOnly(bottom: 15.h);
}
