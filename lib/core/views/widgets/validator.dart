const String emailRegexString =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const String passwordRegexString = r'^[a-zA-Z0-9]{4,}$';
const String usernameRegexString = r'^[a-zA-Z0-9,.-]+$';

abstract class Validator {
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(emailRegexString);
    if (val == null || val.trim().isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(val)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Password cannot be empty';
    } else if (val.length < 4) {
      return 'Password must be at least 4 characters';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(val)) {
      return 'Password must contain only letters and numbers';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.trim().isEmpty) {
      return 'Password cannot be empty';
    } else if (val != password) {
      return 'Confirm password must match the password';
    } else {
      return null;
    }
  }

  static String? validateName(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Name cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateUsername(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Username cannot be empty';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    final phone = val.trim();
    final isValid = RegExp(r'^\+?\d+$').hasMatch(phone);
    if (!isValid || phone.length != 13) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return 'Code cannot be empty';
    } else if (val.length < 6) {
      return 'Code should be at least 6 digits';
    } else {
      return null;
    }
  }
}