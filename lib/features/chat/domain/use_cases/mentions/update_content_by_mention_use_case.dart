class UpdateContentByMentionUseCase {
  const UpdateContentByMentionUseCase();

  String execute({
    required String content,
    required String formattedUsername,
  }) {
    final words = content.split(' ')
      ..removeLast()
      ..add('$formattedUsername ');
    final updatedContent = words.join(' ');

    return updatedContent;
  }
}
