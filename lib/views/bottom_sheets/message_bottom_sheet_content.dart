import 'package:scan_me_plus/export.dart';

class MessageBottomSheetContent extends StatelessWidget {
  final String icon;
  final String messageText;
  final String buttonText;
  final VoidCallback onButtonPress;
  const MessageBottomSheetContent(
      {super.key,
      required this.icon,
      required this.messageText,
      required this.buttonText,
      required this.onButtonPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          height: 55.h,
        ).paddingOnly(bottom: 20.h),
        Text(
          messageText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ).paddingOnly(top: 5.h, bottom: 20.h),
        CustomButton(text: buttonText, onPressed: onButtonPress)
            .paddingOnly(bottom: 10.h)
      ],
    );
  }
}
