import 'package:scan_me_plus/export.dart';

class VehicleListView extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const VehicleListView(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Inkwell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Image.asset(
            AppImages.iconArrowRight,
            height: 10.h,
          )
        ],
      ).paddingSymmetric(vertical: 20.h),
    );
  }
}
