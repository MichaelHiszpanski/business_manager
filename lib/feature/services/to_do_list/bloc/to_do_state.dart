part of 'to_do_bloc.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object?> get props => [];
}

class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoadSuccess extends ToDoState {
  final List<ToDoItem> todos;

  const ToDoLoadSuccess({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class ToDoError extends ToDoState {}
