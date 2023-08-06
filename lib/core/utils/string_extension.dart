extension StringExtension on String {
  String makeShortForm() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 3);
  }
}
