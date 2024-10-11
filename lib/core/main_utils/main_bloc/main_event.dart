part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => [];
}

final class InitializeApp extends MainEvent {
  const InitializeApp();
}

final class UpdateAuthToken extends MainEvent {
  final String authToken;

  const UpdateAuthToken({required this.authToken});

  @override
  List<Object?> get props => [authToken];
}

final class UpdateUser extends MainEvent {
  final User user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UpdateToDoList extends MainEvent {
  final List<ToDoItem> todos;

  const UpdateToDoList({required this.todos});

  @override
  List<Object?> get props => [todos];
}

final class Logout extends MainEvent {
  const Logout();
}
