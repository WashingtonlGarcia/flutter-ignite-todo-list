import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/models/todo_item.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoDefaultState(items: []));

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoCreatedEvent) {
      yield* mapTodoCreatedEventToState(event);
    } else if (event is TodoRemovedEvent) {
      yield* mapTodoRemovedEventToState(event);
    } else if (event is TodoDoneEvent) {
      yield* mapTodoDoneEventToState(event);
    }
  }

  Stream<TodoState> mapTodoCreatedEventToState(TodoCreatedEvent event) async* {
    yield TodoDefaultState(items: (state as TodoDefaultState).items..add(event.item));
  }

  Stream<TodoState> mapTodoRemovedEventToState(TodoRemovedEvent event) async* {
    yield TodoDefaultState(items: (state as TodoDefaultState).items..removeWhere((element) => element.id == event.id));
  }

  Stream<TodoState> mapTodoDoneEventToState(TodoDoneEvent event) async* {
    final item = (state as TodoDefaultState).items.singleWhere((element) => element.id == event.id);
    (state as TodoDefaultState).items.removeWhere((element) => element.id == item.id);
    (state as TodoDefaultState).items.add(item.copyWith(isDone: !item.isDone));
    yield TodoDefaultState(items: (state as TodoDefaultState).items);
  }
}
