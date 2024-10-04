import 'package:scan_me_plus/export.dart';

class HelpSupportScreen extends GetView<HelpSupportController> {
  const HelpSupportScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'help_support'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60.r),
              child: Image.asset(
                AppImages.iconSplashLogo,
                height: 40.h,
                fit: BoxFit.contain,
              ),
            ).paddingSymmetric(vertical: 40.h),
            _form(),
            _submitButton()
          ],
        ).paddingSymmetric(vertical: 20.h, horizontal: 15.w),
      ),
    );
  }

  _form() => Form(
      key: controller.helpSupportFormKey,
      child: Column(
        children: [
          _firstNameTextField(),
          _emailAddressTextField(),
          _commentsTextField(),
        ],
      )).paddingSymmetric(vertical: 25.w);

  _firstNameTextField() => CustomTextField(
        controller: controller.fullNameTextController,
        focusNode: controller.fullNameFocusNode,
        label: 'full_name'.tr,
        textCapitalization: TextCapitalization.sentences,
        validator: (value) =>
            FieldChecker.fieldChecker(value: value, message: 'full_name'.tr),
      ).paddingSymmetric(vertical: 8.h);

  _emailAddressTextField() => CustomTextField(
        controller: controller.emailAddressTextController,
        focusNode: controller.emailAddressFocusNode,
        label: 'email_address'.tr,
        validator: (value) => EmailValidator.validateEmail(value ?? ''),
      ).paddingSymmetric(vertical: 8.h);

  _commentsTextField() => CustomTextField(
        controller: controller.commentsTextController,
        focusNode: controller.commentsFocusNode,
        label: 'comments'.tr,
        textCapitalization: TextCapitalization.sentences,
        maxLines: 3,
        minLines: 3,
        validator: (value) =>
            FieldChecker.fieldChecker(value: value, message: 'comments'.tr),
      ).paddingSymmetric(vertical: 8.h);

  _submitButton() => CustomButton(
      text: 'submit'.tr,
      isLoading: controller.helpSupportLoading,
      onPressed: () {
        if (controller.helpSupportFormKey.currentState!.validate()) {
          controller.helpSupport();
        }
      }).paddingOnly(top: 20.h);
}
