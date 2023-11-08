extension StringExtension on String {
  String intelliTrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

  String numTrim() {
    return length > 6 ? '${substring(0, 16)}...' : this;
  }
}
