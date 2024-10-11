import 'package:bloc/bloc.dart';
import 'package:dissertation_project_app/feature/services/to_do_list/models/to_do_item/to_do_item_model.dart';
import 'package:dissertation_project_app/feature/auth/user/user_model.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitial()) {
    on<InitializeApp>(_onInitializeApp);
    on<UpdateAuthToken>(_onUpdateAuthToken);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateToDoList>(_onUpdateToDoList);
    on<Logout>(_onLogout);
  }

  void _onInitializeApp(InitializeApp event, Emitter<MainState> emit) {
    // Load initial data if necessary
    // For example, check if authToken exists in secure storage
    // If exists, load User data
    // Here, we'll just emit MainInitial or MainLoaded accordingly

    // Example placeholder logic:
    // String? storedAuthToken = await getAuthTokenFromStorage();
    // if (storedAuthToken != null) {
    //   User user = await fetchUserData(storedAuthToken);
    //   emit(MainLoaded(authToken: storedAuthToken, user: user));
    // } else {
    //   emit(const MainInitial());
    // }

    emit(const MainInitial()); // Replace with actual logic
  }

  void _onUpdateAuthToken(UpdateAuthToken event, Emitter<MainState> emit) {
    final currentState = state;
    if (currentState is MainLoaded) {
      emit(MainLoaded(authToken: event.authToken, user: currentState.user));
    } else {
      emit(
          MainLoaded(authToken: event.authToken, user: User(id: '', name: '')));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<MainState> emit) {
    final currentState = state;
    if (currentState is MainLoaded) {
      emit(MainLoaded(authToken: currentState.authToken, user: event.user));
    } else {
      emit(MainLoaded(authToken: '', user: event.user));
    }
  }

  void _onUpdateToDoList(UpdateToDoList event, Emitter<MainState> emit) {
    final currentState = state;
    if (currentState is MainLoaded) {
      emit(MainLoaded(
          authToken: currentState.authToken,
          user: currentState.user,
          todos: event.todos));
    }
  }

  void _onLogout(Logout event, Emitter<MainState> emit) {
    // Clear data and reset to initial state
    emit(const MainInitial());
  }
}
