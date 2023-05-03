class GqlChatSettingsInput {
  GqlChatSettingsInput({
    this.isMuted,
    this.name,
  });

  final bool? isMuted;
  final String? name;

  Map<String, dynamic> toJson() {
    return {
      if (isMuted != null) 'isMuted': isMuted,
      if (name != null) 'name': name,
    };
  }
}
