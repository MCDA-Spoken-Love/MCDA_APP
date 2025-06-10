abstract class DeleteAccountState {}

class DeleteAccountInitialState extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class AccountDeleted extends DeleteAccountState {
  final String message;
  AccountDeleted({required this.message});
}

class DeleteAccountFailure extends DeleteAccountState {
  final String message;
  DeleteAccountFailure({required this.message});
}
