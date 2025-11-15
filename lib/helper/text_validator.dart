class StringValidator {
  static RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  static bool isEmail(String email){
    return emailRegex.hasMatch(email);
  }
}