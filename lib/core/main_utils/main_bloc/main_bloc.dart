import 'package:bloc/bloc.dart';
import 'package:business_manager/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:business_manager/feature/auth/user/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitial()) {
    on<InitializeApp>(_onInitializeApp);
    on<UpdateAuthToken>(_onUpdateAuthToken);
    on<UpdateUser>(_onUpdateUser);
    on<Logout>(_onLogout);
  }

  void _onInitializeApp(InitializeApp event, Emitter<MainState> emit) {
    emit(const MainInitial());
  }

  void _onUpdateAuthToken(
      UpdateAuthToken event, Emitter<MainState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'authToken',
      event.authToken,
    );

    final currentState = state;
    if (currentState is MainLoaded) {
      emit(MainLoaded(
          authToken: event.authToken,
          user: currentState.user,
          todos: currentState.todos));
    } else {
      emit(
        MainLoaded(
          authToken: event.authToken,
          user: const User(id: '', name: ''),
        ),
      );
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<MainState> emit) {
    final currentState = state;
    if (currentState is MainLoaded) {
      emit(
        MainLoaded(
          authToken: currentState.authToken,
          user: event.user,
        ),
      );
    } else {
      emit(
        MainLoaded(
          authToken: '',
          user: event.user,
        ),
      );
    }
  }

  void _onLogout(Logout event, Emitter<MainState> emit) {
    emit(const MainInitial());
  }
}
