import 'package:scan_me_plus/export.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.splashBgColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.kPrimaryColor,
        brightness: Brightness.dark,
        background: Colors.white,
        error: Colors.red,
        secondary: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(),
    buttonTheme: _buttonThemeData(),
  );
}

TextTheme textTheme() {
  return TextTheme(
    displayLarge: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 28.sp,
        fontWeight: FontWeight.w900,
        fontFamily: 'Poppins'),
    displayMedium: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins'),
    displaySmall: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins'),
    headlineLarge: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    headlineMedium: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    headlineSmall: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    titleLarge: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 17.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    titleMedium: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    titleSmall: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
    bodyLarge: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins'),
    bodyMedium: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins'),
    bodySmall: TextStyle(
        color: AppColors.colorTextPrimary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins'),
    labelLarge: TextStyle(
      color: AppColors.colorTextPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 15.sp,
      fontFamily: 'Poppins',
    ),
    labelMedium: TextStyle(
      color: AppColors.colorTextPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 13.sp,
      fontFamily: 'Poppins',
    ),
    labelSmall: TextStyle(
      color: AppColors.colorTextPrimary,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      fontFamily: 'Poppins',
    ),
  );
}

ButtonThemeData _buttonThemeData() {
  return ButtonThemeData(
    buttonColor: AppColors.kPrimaryColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  );
}
