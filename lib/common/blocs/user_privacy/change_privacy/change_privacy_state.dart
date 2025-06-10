abstract class ChangePrivacyState {}

class ChangePrivacyInitialState extends ChangePrivacyState {}

class ChangePrivacyLoading extends ChangePrivacyState {}

class ChangedPrivacySetting extends ChangePrivacyState {}

class ChangePrivacyFailure extends ChangePrivacyState {
  final String message;

  ChangePrivacyFailure({required this.message});
}
