abstract final class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.trim());
  }

  static bool isValidPassword(String password) {
    return password.trim().length >= 6;
  }
}
