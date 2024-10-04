import 'package:scan_me_plus/export.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, this.image, this.title});

  final String? image;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   image ?? AppImages.iconSplashLogo,
          // height: 120.h,),
          Text(
            (title ?? 'no_data_available').tr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 16.sp, color: AppColors.colorTextSecondary),
          ).paddingSymmetric(horizontal: 15.w, vertical: 85.h)
        ],
      ),
    );
  }
}
