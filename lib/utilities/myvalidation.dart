class MyValidation {
  static String? validateEmail(text) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (text.isEmpty || text == null) {
      return 'Please enter your email';
    } else if (!regex.hasMatch(text)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(text) {
    // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    RegExp regex = RegExp(r'^.{8,}$');
    if (text!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(text)) {
        return 'Password must be at least 8 characters long';
        // return "Your password must be at least 8 characters long and include a combination of uppercase and lowercase letters, numbers, and symbols.";
      } else {
        return null;
      }
    }
  }
}
