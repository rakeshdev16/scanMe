import 'package:scan_me_plus/export.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Function() onPressed;
  final double? borderRadius;
  final double? fontSize;
  final double? borderWidth;
  final Color? borderColor;
  final EdgeInsets? padding;
  final RxBool? isLoading;
  final RxBool? isEnable;

  const CustomButton({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    required this.onPressed,
    this.borderRadius,
    this.fontSize,
    this.borderWidth,
    this.borderColor,
    this.padding,
    this.isLoading,
    this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: (isLoading?.value ?? false) == true
            ? Center(
                child: Container(
                height: 40.h,
                width: 40.w,
                margin: padding ??
                    EdgeInsets.only(
                        left: 16.w, right: 16.w, bottom: 8.h, top: 8.h),
                child: SizedBox(
                        height: 40.h,
                        child: const CircularProgressIndicator(
                            color: AppColors.kPrimaryColor).paddingSymmetric(horizontal: 5.w, vertical: 7.h)),
              ))
            : GestureDetector(
                onTap:
                    isEnable?.value ?? RxBool(true).value ? onPressed : () {},
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  padding: padding ??
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
                      color: isEnable?.value ?? RxBool(true).value
                          ? backgroundColor ?? AppColors.kPrimaryColor
                          : backgroundColor ?? AppColors.addNowButtonColor,
                      border: Border.all(
                          color: isEnable?.value ?? RxBool(true).value
                              ? borderColor ?? AppColors.kPrimaryColor
                              : borderColor ?? AppColors.addNowButtonColor)),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: textColor ?? AppColors.colorTextPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize),
                  ),
                ),
              ),
      ),
    );
  }
}
