import 'package:scan_me_plus/export.dart';

class CommonBottomSheetBackground {
  CommonBottomSheetBackground.show({
    required Widget content,
    double? topMargin,
    bool? isDismissible,
  }) {
    Get.bottomSheet(
        Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(
                    AppImages.imgBottomSheetBackground,
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2.5.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20.r)),
                ).paddingOnly(bottom: topMargin ?? 17.h),
                content
              ],
            ).paddingSymmetric(horizontal: 20.w, vertical: 15.h),
          ),
        ),
        isScrollControlled: true,
        elevation: 0,
        enableDrag: false,
        isDismissible: isDismissible ?? true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        )));
  }
}
