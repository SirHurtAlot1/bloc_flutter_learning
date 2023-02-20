import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserGetUserEvent>(_onGetUser);
  }

  _onGetUser(UserGetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    final users = List.generate(
      event.count,
      (index) => User(name: 'name', id: index.toString()),
    );
    emit(UserLoadedState(users));
  }
}
