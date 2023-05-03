enum CommentsMode {
  /// comments displayed in a list that takes entire width of the screen and should not overlap the post
  /// (i.e: link post / poll post)
  list,

  /// comments displayed as an overlay list in bottom left corner, overlays content
  /// (i.e: image post / video post)
  overlay,

  /// comments displayed as a drawer coming from right on half of the screen
  /// (i.e: full screen horizontal video)
  drawer,

  /// don't display comment section at all
  none;
}
