

class ValidationsHelper{
  static String? validateTextField(String? value, {String errorMessage = "This field is required"}) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validateEmail(String? value, {String errorMessage = "Enter a valid email address"}) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

}