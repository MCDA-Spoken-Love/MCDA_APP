import 'package:flutter/services.dart';

class ChangePrivacyEvent {}

class ChangeStatusVisibilitySetting extends ChangePrivacyEvent {
  final VoidCallback onSuccess;

  ChangeStatusVisibilitySetting({required this.onSuccess});
}

class ChangeLastSeenSetting extends ChangePrivacyEvent {
  final VoidCallback onSuccess;

  ChangeLastSeenSetting({required this.onSuccess});
}
