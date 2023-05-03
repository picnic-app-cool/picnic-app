extension PostFormatting on String {
  /// This regex finds every second word and adds a space thereafter
  String get formattedPostTitle => replaceAllMapped(RegExp('((?:.*?\\s){1}.*?)\\s'), (m) => '${m[1]}\n');
}
