import 'package:scan_me_plus/export.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  EditProfileScreen({super.key});

  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'edit_profile'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_editProfileImage(context), _form(), _updateButton()],
        ).paddingSymmetric(horizontal: 15.w, vertical: 20.h),
      ),
    );
  }

  _editProfileImage(context) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          Obx(
            () => Container(
              height: 90.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: controller.profileImage.value == ""
                  ? _networkImage(context)
                  : _selectedImage(),
            ),
          ),
          Inkwell(
            onTap: () {
              PickImageOptionsBottomSheet.show(
                galleryFunction: () {
                  Get.back();
                  controller.updateImageFile(imageFromGallery());
                },
                cameraFunction: () {
                  Get.back();
                  controller.updateImageFile(imageFromCamera());
                },
              );
            },
            child: Image.asset(
              AppImages.iconEditImage,
              height: 20.h,
            ),
          )
        ],
      );

  _networkImage(context) => NetworkImageWidget(
        imageUrl: controller.user.value?.image ?? '',
        imageHeight: 90.h,
        imageWidth: 90.h,
        radiusAll: 100.r,
        imageFitType: BoxFit.fill,
      placeHolderWidget: Container(
        decoration: const BoxDecoration(
          color: AppColors.kPrimaryColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          controller.user.value?.userId?.split('').first.toUpperCase() ??
              '',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 34.sp
          ),
        ),
      )
      );

  _selectedImage() => Obx(
        () => ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Image.file(
            File(controller.profileImage.value),
            fit: BoxFit.fill,
            height: 90.h,
            width: 90.h,
          ),
        ),
      );

  _form() => Form(
      key: editProfileFormKey,
      child: Column(
        children: [
          _firstNameTextField(),
          _lastNameTextField(),
          _emailAddressTextField(),
          _userIdTextField(),
          _pinCodeTextField(),
          _cityStateDropDown(),
          _addressTextField(),
        ],
      )).paddingSymmetric(vertical: 25.w);

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

  _emailAddressTextField() => CustomTextField(
        controller: controller.emailAddressTextController,
        focusNode: controller.emailAddressFocusNode,
        label: 'email_address'.tr,
        isReadOnly: true,
        isRequired: true,
        validator: (value) => EmailValidator.validateEmail(value ?? ''),
      ).paddingSymmetric(vertical: 8.h);

  _userIdTextField() => CustomTextField(
        controller: controller.userIDTextController,
        focusNode: controller.userIdFocusNode,
        label: 'user_id'.tr,
        isRequired: true,
        isReadOnly: true,
      ).paddingSymmetric(vertical: 8.h);

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

  _updateButton() => CustomButton(
      text: 'update_profile'.tr,
      isLoading: controller.registerLoading,
      onPressed: () {
        if (controller.profileImage.value != '') {
          controller.updateProfile();
        } else {
          controller.updateUser();
        }
      }).paddingOnly(bottom: 20.h);
}
