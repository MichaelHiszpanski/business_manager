part of 'main_bloc.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

final class MainInitial extends MainState {
  const MainInitial();
}

final class MainLoaded extends MainState {
  final String authToken;
  final User user;
  final List<ToDoItem>? todos;

  const MainLoaded({required this.authToken, required this.user, this.todos});

  @override
  List<Object?> get props => [authToken, user, todos];
}

final class MainError extends MainState {
  final String message;

  const MainError({required this.message});

  @override
  List<Object?> get props => [message];
}
