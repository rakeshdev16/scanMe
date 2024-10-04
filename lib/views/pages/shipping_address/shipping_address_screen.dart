import 'package:scan_me_plus/export.dart';

class ShippingAddressScreen extends GetView<ShippingAddressController> {
  ShippingAddressScreen({super.key});

  final GlobalKey<FormState> shippingAddressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'shipping_address'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        onBackPress: controller.fromReplacement.value
            ? () {
                Get.back();
              }
            : () {
                Get.offAllNamed(AppRoutes.routeHome);
              },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_form(), _submitButton(context)],
        ).paddingSymmetric(horizontal: 15.w),
      ),
    );
  }

  _form() => Form(
      key: shippingAddressFormKey,
      child: Column(
        children: [
          _firstNameTextField(),
          _lastNameTextField(),
          _pinCodeTextField(),
          _cityStateDropDown(),
          _addressTextField(),
        ],
      )).paddingSymmetric(vertical: 10.w);

  _firstNameTextField() => CustomTextField(
        controller: controller.firstNameTextController,
        focusNode: controller.firstNameFocusNode,
        isRequired: true,
        label: 'first_name'.tr,
        textCapitalization: TextCapitalization.sentences,
        validator: (value) =>
            FieldChecker.fieldChecker(value: value, message: 'first_name'.tr),
      ).paddingSymmetric(vertical: 8.h);

  _lastNameTextField() => CustomTextField(
        controller: controller.lastNameTextController,
        focusNode: controller.lastNameFocusNode,
        textCapitalization: TextCapitalization.sentences,
        label: 'last_name'.tr,
      ).paddingSymmetric(vertical: 8.h);

  _pinCodeTextField() => CustomTextField(
        controller: controller.pinCodeTextController,
        focusNode: controller.pinCodeFocusNode,
        isRequired: true,
        label: 'pincode'.tr,
        validator: (value) =>
            FieldChecker.fieldChecker(value: value, message: 'pincode'.tr),
      ).paddingSymmetric(vertical: 8.h);

  _addressTextField() => CustomTextField(
        controller: controller.addressTextController,
        focusNode: controller.addressFocusNode,
        isRequired: true,
        label: 'address'.tr,
        textCapitalization: TextCapitalization.sentences,
        minLines: 3,
        maxLines: 3,
        validator: (value) =>
            FieldChecker.fieldChecker(value: value, message: 'address'.tr),
      ).paddingSymmetric(vertical: 8.h);

  _cityStateDropDown() => Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.stateList.isNotEmpty ? _stateDropDown() : Container(),
            SizedBox(
              width: 15.w,
            ),
            controller.cityList.isNotEmpty ? _cityDropDown() : Container(),
          ],
        ).paddingSymmetric(vertical: 8.h),
      );

  _stateDropDown() => Obx(
        () => Expanded(
          child: CustomDropdown<String>(
            dropdownItems: controller.stateList.map((item) {
              return item.name;
            }).toList(),
            focusNode: controller.stateFocusNode,
            isRequired: true,
            dropdownValue: controller.selectedState.value == ''
                ? null
                : controller.selectedState.value,
            label: 'state'.tr,
            hint: 'select'.tr,
            validate: (value) =>
                FieldChecker.fieldChecker(value: value, message: 'state'.tr),
            onChanged: (state) {
              controller.selectedState.value = state;
              controller.selectedState.refresh();
              controller.selectedCity.value = '';
              var index = controller.statesData.value.states?.indexWhere(
                  (element) => element.name == controller.selectedState.value);
              if (index != -1) {
                controller.cityList.value =
                    controller.statesData.value.states![index!].cities!;
              }
              controller.cityList.refresh();
            },
          ),
        ),
      );

  _cityDropDown() => Expanded(
        child: CustomDropdown<String>(
          dropdownItems: controller.cityList.map((item) {
            return item.name;
          }).toList(),
          focusNode: controller.cityFocusNode,
          isRequired: true,
          dropdownValue: controller.selectedCity.value == ''
              ? null
              : controller.selectedCity.value,
          label: 'city'.tr,
          hint: 'select'.tr,
          validate: (value) =>
              FieldChecker.fieldChecker(value: value, message: 'city'.tr),
          onChanged: (city) {
            controller.selectedCity.value = city;
            controller.selectedCity.refresh();
          },
        ),
      );

  _submitButton(context) => CustomButton(
      text: 'submit'.tr,
      isLoading: controller.shippingAddressLoading,
      onPressed: () {
        if (shippingAddressFormKey.currentState!.validate()) {
          FocusManager.instance.primaryFocus?.unfocus();
          _sureToSubmitBottomSheet(context);
        }
      }).paddingOnly(bottom: 30.h, top: 60.h);

  _sureToSubmitBottomSheet(context) => CommonBottomSheetBackground.show(
      content: Column(
        children: [
          Text('sure_to_submit'.tr,
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
                        controller.addShippingAddress(context);
                      })),
              SizedBox(
                width: 10.h,
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
      ),
      isDismissible: false);
}
