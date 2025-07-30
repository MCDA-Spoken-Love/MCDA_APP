import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mcda_app/common/blocs/relationship/relationship_display_state.dart';
import 'package:mcda_app/domain/entities/relationship.dart';
import 'package:mcda_app/domain/usecases/relationship/get_relationship.dart';

class RelationshipDisplayCubit extends HydratedCubit<RelationshipDisplayState> {
  RelationshipDisplayCubit() : super(RelationShipDisplayLoading());

  void displayRelationship() async {
    var result = await GetRelationshipUseCase().call();
    result.fold(
      (error) {
        emit(LoadRelationShipFailure(errorMessage: error));
      },
      (data) {
        emit(RelationShipDisplayLoaded(relationships: data));
      },
    );
  }

  @override
  RelationshipDisplayState? fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'RelationShipDisplayLoaded':
        final relList =
            (json['relationships'] as List)
                .map((e) => RelationshipEntity.fromJson(e))
                .toList();
        return RelationShipDisplayLoaded(relationships: relList);
      case 'LoadRelationShipFailure':
        return LoadRelationShipFailure(errorMessage: json['errorMessage']);
      case 'UserLoading':
      default:
        return RelationShipDisplayLoading();
    }
  }

  @override
  Map<String, dynamic>? toJson(RelationshipDisplayState state) {
    if (state is RelationShipDisplayLoaded) {
      return {
        'type': 'RelationShipDisplayLoaded',
        'relationships': state.relationships.map((e) => e.toJson()).toList(),
      };
    } else if (state is LoadRelationShipFailure) {
      return {'type': 'LoadUserFailure', 'errorMessage': state.errorMessage};
    } else if (state is RelationShipDisplayLoading) {
      return {'type': 'UserLoading'};
    }
    return null;
  }
}
