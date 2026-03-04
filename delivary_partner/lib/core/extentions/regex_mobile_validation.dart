// 1. Add this regex validator at the top or in a helper
bool _isValidIndianMobile(String number) {
  final regex = RegExp(r'^[6-9]\d{9}$');
  return regex.hasMatch(number.trim());
}