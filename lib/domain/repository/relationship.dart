import 'package:dartz/dartz.dart';

abstract class RelationshipRepository {
  Future<Either> getRelationship();
  Future<Either> terminateRelationship();
}
