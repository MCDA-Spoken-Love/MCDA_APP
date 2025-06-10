import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/relationship_termination/relationship_termination_event.dart';
import 'package:mcda_app/common/blocs/relationship_termination/relationship_termination_state.dart';
import 'package:mcda_app/domain/usecases/user/terminate_relationship.dart';

class RelationshipTermationBloc
    extends Bloc<RelationshipTerminationEvent, RelationshipTerminationState> {
  RelationshipTermationBloc() : super(RelationshipInitialState()) {
    on<RelationshipTerminationCallback>((event, emit) async {
      emit(RelationshipTerminationLoading());
      final res = await TerminateRelationshipUseCase().call();
      res.fold(
        (failure) {
          emit(RelationshipTerminationFailure(message: failure));
          return Left(failure);
        },
        (success) {
          emit(RelationshipTerminated(message: success['message']));
          return Right(success);
        },
      );
    });
  }
}
