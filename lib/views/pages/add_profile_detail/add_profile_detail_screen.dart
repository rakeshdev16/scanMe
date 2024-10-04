import 'package:scan_me_plus/export.dart';

class AddProfileDetailScreen extends GetView<AddProfileDetailController> {
  AddProfileDetailScreen({super.key});

  final GlobalKey<FormState> addProfileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        onBackPress: controller.isFromHome.value
            ? () {
                Get.back();
              }
            : () {
                Get.offAllNamed(AppRoutes.routeLogin);
              },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'add_profile_details'.tr,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            _form(context),
            _submitButton()
          ],
        ).paddingSymmetric(horizontal: 15.w),
      ),
    );
  }

  _form(context) => Form(
      key: addProfileFormKey,
      child: Column(
        children: [
          _firstNameTextField(),
          _lastNameTextField(),
          _emailAddressTextField(),
          _emailIdAvailability(context),
          SizedBox(
            height: 8.h,
          ),
          _userIdTextField(),
          _userIdAvailability(context),
          SizedBox(
            height: 8.h,
          ),
          _pinCodeTextField(),
          _cityStateDropDown(),
          _addressTextField(),
        ],
      )).paddingSymmetric(vertical: 25.w);

  _firstNameTextField() => CustomTextField(
        controller: controller.firstNameTextController,
        focusNode: controller.firstNameFocusNode,
        isRequired: true,
        textCapitalization: TextCapitalization.sentences,
        label: 'first_name'.tr,
        validator: (value) =>
            FieldChecker.fieldChecker(value: value, message: 'first_name'.tr),
      ).paddingSymmetric(vertical: 8.h);

  _lastNameTextField() => CustomTextField(
        controller: controller.lastNameTextController,
        focusNode: controller.lastNameFocusNode,
        textCapitalization: TextCapitalization.sentences,
        label: 'last_name'.tr,
      ).paddingSymmetric(vertical: 8.h);

  _emailAddressTextField() => CustomTextField(
        controller: controller.emailAddressTextController,
        focusNode: controller.emailAddressFocusNode,
        isRequired: true,
        label: 'email_address'.tr,
        validator: (value) => EmailValidator.validateEmail(value ?? ''),
      ).paddingOnly(top: 8.h);

  _emailIdAvailability(context) => Obx(
        () => Visibility(
          visible: controller.isShowEmailExist.value,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "email_not_available".tr,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300),
            ).paddingOnly(left: 15.w, top: 2.h),
          ),
        ),
      );

  _userIdTextField() => CustomTextField(
        controller: controller.userIDTextController,
        focusNode: controller.userIdFocusNode,
        label: 'user_id'.tr,
        isRequired: true,
        onChange: (value) {
          controller.isShowsUserIdExist.value = -1;
        },
        suffixIcon: Obx(
          () => controller.userIdValue.value == ''
              ? const SizedBox()
              : controller.isShowsUserIdExist.value == -1
                  ? SizedBox(
                      height: 15.h,
                      width: 15.h,
                      child: const CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ).paddingAll(12.h),
                    )
                  : Image.asset(
                      controller.isShowsUserIdExist.value == 0
                          ? AppImages.iconUserNameNotAvailable
                          : AppImages.iconUserNameAvailable,
                      height: 12.h,
                    ).paddingSymmetric(vertical: 10.h),
        ),
        textCapitalization: TextCapitalization.sentences,
        validator: (value) =>
            FieldChecker.fieldChecker(value: value, message: 'user_id'.tr),
      ).paddingOnly(top: 8.h);

  _userIdAvailability(context) => Obx(
        () => Visibility(
          visible: (controller.isShowsUserIdExist.value == 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "username_not_available".tr,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300),
            ).paddingOnly(left: 15.w, top: 2.h),
          ),
        ),
      );

  _pinCodeTextField() => CustomTextField(
        controller: controller.pinCodeTextController,
        focusNode: controller.pinCodeFocusNode,
        label: 'pincode'.tr,
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
      ).paddingSymmetric(vertical: 8.h);

  _addressTextField() => CustomTextField(
        controller: controller.addressTextController,
        focusNode: controller.addressFocusNode,
        label: 'address'.tr,
        textCapitalization: TextCapitalization.sentences,
        minLines: 3,
        maxLines: 3,
      ).paddingSymmetric(vertical: 8.h);

  _cityStateDropDown() => Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
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
            dropdownValue: controller.selectedState.value == ''
                ? null
                : controller.selectedState.value,
            label: 'state'.tr,
            hint: 'select'.tr,
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
          dropdownValue: controller.selectedCity.value == ''
              ? null
              : controller.selectedCity.value,
          label: 'city'.tr,
          hint: 'select'.tr,
          onChanged: (city) {
            controller.selectedCity.value = city;
            controller.selectedCity.refresh();
          },
        ),
      );

  _submitButton() => CustomButton(
      text: 'submit'.tr,
      isLoading: controller.registerLoading,
      onPressed: () {
        if (addProfileFormKey.currentState!.validate()) {
          controller.registerUser();
        }
      }).paddingOnly(bottom: 30.h);
}
