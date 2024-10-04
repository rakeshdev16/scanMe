import 'package:scan_me_plus/export.dart';

class CommonAlertDialog {
  CommonAlertDialog._();

  static showDialog({
    String? title,
    required String message,
    String? negativeText,
    required String positiveText,
    bool? isShowNegButton,
    VoidCallback? negativeBtCallback,
    bool? barrierDismissible,
    BuildContext? builder,
    required VoidCallback positiveBtCallback,
  }) {
    Get.dialog(
        Dialog(
          backgroundColor: AppColors.splashBgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          child: CommonDialogContent(
            title: title,
            message: message,
            negativeText: negativeText,
            positiveText: positiveText,
            isShowNegButton: isShowNegButton,
            positiveBtCallback: positiveBtCallback,
            negativeBtCallback: negativeBtCallback,
          ),
        ),
        barrierDismissible: barrierDismissible ?? true);
  }
}

class CommonDialogContent extends StatelessWidget {
  const CommonDialogContent({
    Key? key,
    this.title,
    required this.message,
    this.negativeText,
    required this.positiveText,
    this.isShowNegButton,
    required this.positiveBtCallback,
    this.negativeBtCallback,
    this.positiveTextColor,
    this.negativeTextColor,
  }) : super(key: key);

  final String? title;
  final String message;
  final String? negativeText;
  final String positiveText;
  final Color? positiveTextColor;
  final Color? negativeTextColor;
  final bool? isShowNegButton;
  final VoidCallback positiveBtCallback;
  final VoidCallback? negativeBtCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.splashBgColor, borderRadius: BorderRadius.circular(20.r)),
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (title ?? "alert").tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              message.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Visibility(
                visible: negativeText != null,
                child: Expanded(
                    child: CustomButton(
                  text: (negativeText ?? "").tr,
                  onPressed: negativeBtCallback ?? () {},
                  // backgroundColor: AppColors.color_bt_dialog_cancel,
                  textColor: negativeTextColor ?? Colors.white,
                  borderRadius: 10,
                )),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: CustomButton(
                text: positiveText.tr,
                textColor: positiveTextColor ?? Colors.white,
                onPressed: positiveBtCallback,
                borderRadius: 10,
              ))
            ],
          )
        ],
      ),
    );
  }
}
