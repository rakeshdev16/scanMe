import 'package:scan_me_plus/export.dart';

class AppAlerts {
  AppAlerts._();

  static message({required String message}) {
    Get.closeAllSnackbars();
    Get.snackbar('alert'.tr, message,
        colorText: AppColors.colorTextPrimary, backgroundColor: Colors.black12);
  }

  static success({required String message}) => Get.defaultDialog(
      backgroundColor: Colors.black.withOpacity(0.7),
      title: 'success'.tr,
      titleStyle: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      content: Column(
        children: [
          Image.asset(
            AppImages.iconUserNameAvailable,
            height: 40.h,
          ).paddingOnly(bottom: 20.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
        ],
      ));

  static error({required String message}) => Get.defaultDialog(
    barrierDismissible: false,
      backgroundColor: Colors.black.withOpacity(0.7),
      title: 'alert'.tr,
      titleStyle: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      content: Column(
        children: [
          Inkwell(
            onTap: (){
              Get.back();
            },
            child: Image.asset(
              AppImages.iconUserNameNotAvailable,
              height: 40.h,
            ).paddingOnly(bottom: 20.h),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
        ],
      ));

  static alert({required String message}) => Get.defaultDialog(
      backgroundColor: Colors.black.withOpacity(0.7),
      title: 'alert'.tr,
      titleStyle: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      content: Column(
        children: [
          Image.asset(
            AppImages.iconDanger,
            color: Colors.red,
            height: 40.h,
          ).paddingOnly(bottom: 20.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
        ],
      ));

  static custom({ required String message}) {
    Get.closeAllSnackbars();
    Get.snackbar(
    AppConsts.appName,
        message,
        colorText: AppColors.colorTextPrimary, backgroundColor: Colors.black12);
  }

  static logoutError({required String message}) => Get.defaultDialog(
    barrierDismissible: false,
      backgroundColor: Colors.black.withOpacity(0.7),
      title: 'alert'.tr,
      titleStyle: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      content: Column(
        children: [
          Inkwell(
            onTap: (){
              if (Get.currentRoute != AppRoutes.routeLogin) {
                Get.offAllNamed(AppRoutes.routeLogin);
              }else{
                Get.back();
              }
            },
            child: Image.asset(
              AppImages.iconUserNameNotAvailable,
              height: 40.h,
            ).paddingOnly(bottom: 20.h),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
        ],
      ));

}
