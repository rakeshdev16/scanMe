import 'package:scan_me_plus/export.dart';

class CommonProgressBar extends StatelessWidget {
  const CommonProgressBar({Key? key, this.size, this.strokeWidth})
      : super(key: key);

  final double? size;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey.shade400,
          color: AppColors.kPrimaryColor,
          strokeWidth: strokeWidth ?? 4.0,
        ),
      ),
    );
  }
}
