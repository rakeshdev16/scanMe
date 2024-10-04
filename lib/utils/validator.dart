import 'package:scan_me_plus/export.dart';

/*========================Email Validator==============================================*/
class EmailValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'email_cannot_be_empty'.tr;
    } else if (!GetUtils.isEmail(value.trim())) {
      return 'enter_valid_email'.tr;
    }
    return null;
  }
}

/*================================================== Phone Number Validator ===================================================*/

class MobileNumberValidate {
  static String? validateMobile(String value) {
    if (value.isEmpty) {
      return 'mobile_cannot_be_empty'.tr;
    } else if (value.length < 10) {
      return 'enter_10_digit_mobile'.tr;
    } else if (!validateNumber(value)) {
      return 'enter_valid_mobile'.tr;
    }
    return null;
  }
}

bool validateNumber(String value) {
  var pattern = r'^[0-9]+$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

/*================================================== Vehicle Number Validator ===================================================*/

class VehicleNumberValidate {
  static String? validateVehicle(String value) {
    if (value.isEmpty) {
      return ' '; // Vehicle number cannot be empty
    }
    return null;
  }
}

bool validateVehicleNumber(String value) {
  var pattern = r'^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

/*===============================Field Checker=================================================*/
class FieldChecker {
  static String? fieldChecker({String? value, message}) {
    if (value == null || value.toString().trim().isEmpty) {
      return "$message ${'cannot_be_empty'.tr}";
    }
    return null;
  }
}

/// Uppercase text formater
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(oldValue, TextEditingValue newValue) =>
      TextEditingValue(
          text: newValue.text.toUpperCase(), selection: newValue.selection);
}
