part of 'todo_bloc.dart';

abstract class TodoEvent {}

class TodoCreatedEvent extends TodoEvent {
  final ToDoItem item;

  TodoCreatedEvent({required this.item});
}

class TodoRemovedEvent extends TodoEvent {
  final String id;

  TodoRemovedEvent({required this.id});
}

class TodoDoneEvent extends TodoEvent {
  final String id;

  TodoDoneEvent({required this.id});
}
