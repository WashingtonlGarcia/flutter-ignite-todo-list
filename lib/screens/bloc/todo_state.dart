part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoDefaultState extends TodoState {
  final List<ToDoItem> items;

  TodoDefaultState({required this.items});
}
