import 'package:mcda_app/domain/entities/relationship.dart';

abstract class RelationshipDisplayState {}

class RelationShipDisplayInitial extends RelationshipDisplayState {}

class RelationShipDisplayLoading extends RelationshipDisplayState {}

class RelationShipDisplayLoaded extends RelationshipDisplayState {
  final List<RelationshipEntity> relationships;

  RelationShipDisplayLoaded({required this.relationships});
}

class LoadRelationShipFailure extends RelationshipDisplayState {
  final String errorMessage;

  LoadRelationShipFailure({required this.errorMessage});
}
