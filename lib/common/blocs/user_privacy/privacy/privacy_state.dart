class PrivacyState {
  final bool statusVisibilityEnabled;
  final bool lastSeenEnabled;
  final bool biometricLockEnabled;

  PrivacyState({
    required this.statusVisibilityEnabled,
    required this.lastSeenEnabled,
    required this.biometricLockEnabled,
  });

  PrivacyState copyWith({
    bool? statusVisibilityEnabled,
    bool? lastSeenEnabled,
    bool? biometricLockEnabled,
  }) {
    return PrivacyState(
      statusVisibilityEnabled:
          statusVisibilityEnabled ?? this.statusVisibilityEnabled,
      lastSeenEnabled: lastSeenEnabled ?? this.lastSeenEnabled,
      biometricLockEnabled: biometricLockEnabled ?? this.biometricLockEnabled,
    );
  }

  Map<String, dynamic> toMap() => {
    'statusVisibilityEnabled': statusVisibilityEnabled,
    'lastSeenEnabled': lastSeenEnabled,
    'biometricLockEnabled': biometricLockEnabled,
  };

  factory PrivacyState.fromMap(Map<String, dynamic> map) => PrivacyState(
    statusVisibilityEnabled: map['statusVisibilityEnabled'] ?? false,
    lastSeenEnabled: map['lastSeenEnabled'] ?? false,
    biometricLockEnabled: map['biometricLockEnabled'] ?? false,
  );
}
