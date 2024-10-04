import 'package:scan_me_plus/export.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController());
    }
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AppImages.imgLoginBg,
            ),
            _loginContent(context)
          ],
        ),
      ),
    );
  }

  _loginContent(context) => Column(
        children: [
          Text(
            'login_introduction'.tr,
            style: Theme.of(context).textTheme.displayMedium,
          ).paddingOnly(top: 5.h),
          _textField(context),
          _getOTPButton(),
          _terms(context)
        ],
      ).paddingOnly(bottom: 20.w, left: 15.w, right: 15.w);

  _textField(context) => Form(
        key: loginFormKey,
        child: CustomTextField(
          label: 'mobile_number'.tr,
          hint: 'enter_mobile_number'.tr,
          focusNode: controller.mobileNumberFocusNode,
          controller: controller.mobileNumberTextController,
          textInputAction: TextInputAction.done,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          maxLength: 10,
          validator: (value) => MobileNumberValidate.validateMobile(value!),
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '+91',
                style: Theme.of(context).textTheme.bodyLarge,
              ).paddingOnly(right: 10.w, left: 10.w),
              Container(
                color: Colors.white,
                width: 1.2.w,
                height: 25.h,
              ).paddingOnly(right: 10.w)
            ],
          ).paddingSymmetric(vertical: 10.w),
        ).paddingSymmetric(vertical: 20.w),
      );

  _getOTPButton() => CustomButton(
      text: 'get_otp'.tr,
      isLoading: controller.isLoading,
      isEnable: controller.isShowPhoneExist,
      onPressed: () {
        if (loginFormKey.currentState!.validate()) {
          controller.getOtpClick();
        }
      });

  _terms(context) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'agree_continue'.tr,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(height: 2.2, fontSize: 11.sp),
            children: [
              TextSpan(
                text: 'terms_of_use'.tr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline, fontSize: 11.sp),
                recognizer: TapGestureRecognizer()
                  ..onTap =() {
                    Get.toNamed(AppRoutes.routeStaticPage,
                        arguments: {'pageType': 'terms_of_use'.tr});
                  },
              ),
              WidgetSpan(
                child: SizedBox(width: 10.w),
              ),
              TextSpan(
                text: 'privacy_policy'.tr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline, fontSize: 11.sp),
                recognizer: TapGestureRecognizer()
                  ..onTap =() {
                    Get.toNamed(AppRoutes.routeStaticPage,
                        arguments: {'pageType': 'privacy_policy'.tr});
                  },
              ),
              WidgetSpan(
                child: SizedBox(width: 10.w),
              ),
              TextSpan(
                text: 'content_policy'.tr,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline, fontSize: 11.sp),
                recognizer: TapGestureRecognizer()
                  ..onTap =() {
                    Get.toNamed(AppRoutes.routeStaticPage,
                        arguments: {'pageType': 'content_policy'.tr});
                  },
              ),
              TextSpan(
                text: '.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline, fontSize: 11.sp),
              ),
            ]),
      ).paddingOnly(top: 45.sp);
}
