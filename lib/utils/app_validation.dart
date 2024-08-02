class AppValidation {
  String? validatePassword(String value, context) {
    RegExp upperCase = RegExp('(?=.*?[A-Z])');
    RegExp lowerCase = RegExp('(?=.*[a-z])');
    RegExp numric = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[+_%!@#\$&*~]).{8,}$');
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[+_%!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.trim().length < 8) {
      return 'Password Must be at least 8 characters';
    } else if (!upperCase.hasMatch(value)) {
      return 'please enter uppercase letter or lowercase letter or special letter';
    } else if (!lowerCase.hasMatch(value)) {
      return 'please enter uppercase letter or lowercase letter or special letter';
    } else if (!numric.hasMatch(value)) {
      return 'please enter uppercase letter or lowercase letter or special letter';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value, context) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])+)$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validateNumberWithText(String? value, context) {
    String pattern = r'^(?=.*[a-zA-Z])[\w\d]+$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (!regExp.hasMatch(value)) {
      return 'Can\'t have numbers only';
    }

    return null;
  }

  String? validateText(String? value, context) {
    String pattern = r'^[a-zA-Z]+$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (!regExp.hasMatch(value)) {
      return 'Can\'t have numbers';
    }

    return null;
  }
}
