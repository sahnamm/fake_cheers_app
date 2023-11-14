import 'package:fake_cheers_app/network/repository/lucky_person_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lucky_person_event.dart';
part 'lucky_person_state.dart';

class LuckyPersonBloc extends Bloc<LuckyPersonEvent, LuckyPersonState> {
  final LuckyPersonRepository _repository;
  LuckyPersonBloc(this._repository) : super(LuckyPersonInitial()) {
    on<LuckyPersonFetched>((event, emit) async {
      try {
        emit(LuckPersonFetchedInProgress());
        final response = await _repository.getLuckyPerson();
        emit(LuckPersonFetchedSuccess(name: response));
      } catch (e) {
        emit(LuckPersonFetchedFailure());
      }
    });

    on<LuckyPersonReset>((event, emit) {
      emit(LuckyPersonInitial());
    });
  }
}
