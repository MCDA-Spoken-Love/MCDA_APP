abstract class RelationshipTerminationState {}

class RelationshipInitialState extends RelationshipTerminationState {}

class RelationshipTerminationLoading extends RelationshipTerminationState {}

class RelationshipTerminated extends RelationshipTerminationState {
  final String message;
  RelationshipTerminated({required this.message});
}

class RelationshipTerminationFailure extends RelationshipTerminationState {
  final String message;
  RelationshipTerminationFailure({required this.message});
}
