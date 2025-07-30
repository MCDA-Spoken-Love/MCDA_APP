import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:mcda_app/common/utils/map_to_string.dart';
import 'package:mcda_app/data/source/relationship_api_service.dart';
import 'package:mcda_app/domain/repository/relationship.dart';

Logger logger = Logger(
  printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
);

class RelationshipRepositoryImpl extends RelationshipRepository {
  @override
  Future<Either> getRelationship() async {
    Either result = await RelationshipApiServiceImpl().getRelationship();
    return result.fold(
      (error) {
        return Left(mapToString(error.data));
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> terminateRelationship() async {
    Either result = await RelationshipApiServiceImpl().terminateRelationship();
    return result.fold(
      (error) {
        return Left(mapToString(error.data));
      },
      (data) async {
        return Right(data);
      },
    );
  }
}
