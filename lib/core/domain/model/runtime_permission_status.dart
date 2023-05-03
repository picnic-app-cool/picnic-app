enum RuntimePermissionStatus {
  /// the status was not determined (yet)
  unknown,

  /// The user granted access to the requested feature.
  granted,

  /// The user denied access to the requested feature.
  denied,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  restricted,

  ///User has authorized this application for limited access.
  /// *Only supported on iOS (iOS14+).*
  limited,

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  permanentlyDenied;

  static bool isDenied(RuntimePermissionStatus status) => status == denied || status == permanentlyDenied;

  static bool isGranted(RuntimePermissionStatus status) => status == granted;
}
