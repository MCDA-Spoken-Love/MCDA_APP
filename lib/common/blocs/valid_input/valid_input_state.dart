abstract class ValidInputState {}

class ValidInputInitialState extends ValidInputState {}

class ValidInputLoadingState extends ValidInputState {}

class InvalidInput extends ValidInputState {
  final String errorMessage;

  InvalidInput({required this.errorMessage});
}

class ValidatedInput extends ValidInputState {
  final String successMessage;

  ValidatedInput({required this.successMessage});
}
