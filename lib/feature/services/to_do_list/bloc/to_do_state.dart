part of 'to_do_bloc.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object?> get props => [];
}

class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoadSuccess extends ToDoState {
  final List<ToDoItem> toDoList;

  const ToDoLoadSuccess({required this.toDoList});

  @override
  List<Object?> get props => [toDoList];
}

class ToDoError extends ToDoState {}
