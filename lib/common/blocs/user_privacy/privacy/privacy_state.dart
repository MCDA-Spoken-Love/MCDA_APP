class PrivacyState {
  final bool statusVisibilityEnabled;
  final bool lastSeenEnabled;

  PrivacyState({
    required this.statusVisibilityEnabled,
    required this.lastSeenEnabled,
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
    );
  }

  Map<String, dynamic> toMap() => {
    'statusVisibilityEnabled': statusVisibilityEnabled,
    'lastSeenEnabled': lastSeenEnabled,
  };

  factory PrivacyState.fromMap(Map<String, dynamic> map) => PrivacyState(
    statusVisibilityEnabled: map['statusVisibilityEnabled'] ?? false,
    lastSeenEnabled: map['lastSeenEnabled'] ?? false,
  );
}
