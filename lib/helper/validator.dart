import 'package:easy_localization/easy_localization.dart';

class Validator {
  static const String _emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static const String _phoneRegex = r'^\+?[0-9]{10,12}$';

  static const String _studentIdRegex = r'^[0-9]{5,10}$';

  static String? isRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'validator.is_required'.tr(namedArgs: {'field': fieldName.tr()});
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final requiredError = isRequired(value, 'field.password');
    if (requiredError != null) return requiredError;

    if (value!.length < 8) {
      return 'validator.password_min_length'.tr();
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'validator.password_uppercase'.tr();
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'validator.password_lowercase'.tr();
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'validator.password_digit'.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    final requiredError = isRequired(value, 'field.confirm_password');
    if (requiredError != null) return requiredError;

    if (value != originalPassword) {
      return 'validator.password_mismatch'.tr();
    }
    return null;
  }

  static String? validateName(String? value) {
    final requiredError = isRequired(value, 'field.name');
    if (requiredError != null) return requiredError;

    if (value!.length < 2) {
      return 'validator.name_min_length'.tr();
    }
    return null;
  }

  static String? validateSurname(String? value) {
    final requiredError = isRequired(value, 'field.surname');
    if (requiredError != null) return requiredError;

    if (value!.length < 2) {
      return 'validator.surname_min_length'.tr();
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final requiredError = isRequired(value, 'field.email');
    if (requiredError != null) return requiredError;

    if (!RegExp(_emailRegex, caseSensitive: false).hasMatch(value!)) {
      return 'validator.email_invalid'.tr();
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    final requiredError = isRequired(value, 'field.phone_number');
    if (requiredError != null) return requiredError;

    final cleanedValue = value!.replaceAll(RegExp(r'[^\d]'), '');

    if (!RegExp(_phoneRegex).hasMatch(cleanedValue)) {
      return 'validator.phone_invalid'.tr();
    }
    return null;
  }

  static String? validateAddress(String? value) {
    final requiredError = isRequired(value, 'field.address');
    if (requiredError != null) return requiredError;

    if (value!.length < 10) {
      return 'validator.address_min_length'.tr();
    }
    return null;
  }

  static String? validateStudentId(String? value) {
    final requiredError = isRequired(value, 'field.student_id');
    if (requiredError != null) return requiredError;

    if (!RegExp(_studentIdRegex).hasMatch(value!)) {
      return 'validator.student_id_invalid'.tr();
    }
    return null;
  }

  static String? validateSchoolCode(String? value) {
    final requiredError = isRequired(value, 'field.school_code');
    if (requiredError != null) return requiredError;

    if (value!.length != 8) {
      return 'validator.school_code_length'.tr();
    }
    return null;
  }
}
