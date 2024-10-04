import 'package:scan_me_plus/export.dart';

class OtpVerificationScreen extends GetView<OtpVerificationController> {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        isLeadingVisible: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '${'otp_introduction'.tr} ${controller.loginRequestBody!['countryCode']} ${controller.loginRequestBody!['mobile']}.',
                // '${controller.isFromLogin.value ? controller.loginRequestBody!['countryCode'] : controller.registerRequestBody?['countryCode']} ${controller.isFromLogin.value ? controller.loginRequestBody!['mobile'] : controller.registerRequestBody?['mobile']}',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              _textField(context),
              controller.registerLoading.value
                  ? Container(
                      height: 40.h,
                      width: 40.w,
                      margin: EdgeInsets.only(
                          left: 15.h, right: 15.w, bottom: 8.h, top: 8.h),
                      child: SizedBox(
                              height: 38.h,
                              child: const CircularProgressIndicator(
                                  color: AppColors.kPrimaryColor))
                          .paddingAll(7.0),
                    )
                  : Container(),
              _otpMatches(context),
              SizedBox(
                height: 20.h,
              ),
              // _submitButton(),
              _resend(context),
            ],
          ),
          _backToLogin(context),
        ],
      ).paddingSymmetric(horizontal: 15.w),
    );
  }

  _textField(context) => CustomTextField(
        label: 'enter_otp'.tr,
        focusNode: controller.otpFocusNode,
        controller: controller.otpTextController,
        textInputAction: TextInputAction.done,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        maxLength: 4,
        onChange: (value) {
          controller.onOtpTextFieldChange(value);
        },
      ).paddingOnly(
        top: 20.w,
      );

  _otpMatches(context) => Obx(
        () => Visibility(
          visible: controller.otpErrorMessage.value != '',
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.otpErrorMessage.value,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300),
            ).paddingOnly(left: 15.w, top: 2.h),
          ),
        ),
      );

  _submitButton() => CustomButton(
      text: 'submit'.tr,
      isLoading: controller.registerLoading,
      onPressed: () {
        controller
            .onOtpTextFieldChange(controller.otpTextController.text.trim());
      }).paddingOnly(top: 100.h);

  _resend(context) => Obx(
        () => RichText(
            text: TextSpan(
                text: 'did_not_get_otp'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
              TextSpan(
                  text: 'resend_sms'.tr,
                  recognizer: TapGestureRecognizer()
                    ..onTap = controller.start.value == 0
                        ? () {
                            controller.requestResendOtp();
                          }
                        : () {},
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: controller.start.value == 0
                          ? AppColors.kPrimaryColor
                          : AppColors.colorTextSecondary)),
              controller.start.value == 0
                  ? const WidgetSpan(child: SizedBox())
                  : TextSpan(
                      text: " in ${controller.start.value}s".tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.colorTextSecondary,
                          ))
            ])).paddingSymmetric(vertical: 10.h),
      );

  _backToLogin(context) => Inkwell(
          child: Text(
            'go_back_to_login'.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.kPrimaryColor),
          ),
          onTap: () => Get.offAllNamed(AppRoutes.routeLogin))
      .paddingOnly(bottom: 20.h);
}
