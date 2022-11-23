extension TitleCaseX on String {
  String toTitleCase() {
    final words = split(' ');
    String result = '';
    for (var word in words) {
      final first= word[0].toUpperCase();
      result += first + word.substring(1) + ' ';
    }
    return result;
  }
}
