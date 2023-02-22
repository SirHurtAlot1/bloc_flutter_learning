import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetUserEvent>(_onGetUser);
    on<UserGetUserJobEvent>(_onGetUserJob);
  }

  _onGetUser(UserGetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final users = List.generate(
      event.count,
      (index) => User(name: 'name', id: index.toString()),
    );
    emit(state.copyWith(users: users));
  }

  _onGetUserJob(UserGetUserJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final jobs = List.generate(
      event.count,
      (index) => Job(name: 'job', id: index.toString()),
    );
    emit(state.copyWith(jobs: jobs));
  }
}
