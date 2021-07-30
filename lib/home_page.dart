import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'screens/done_screen.dart';
import 'screens/task_screen.dart';
import 'shared/models/todo_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoBloc controller = TodoBloc();

  final _pageViewController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  var _selectedIndex = 0;

  void onAddItem(String itemTitle) => controller.add(TodoCreatedEvent(item: ToDoItem(title: itemTitle, id: Uuid().v1())));

  void onRemoveItem(ToDoItem item) => controller.add(TodoRemovedEvent(id: item.id));

  void onDoneItem(ToDoItem item) => controller.add(TodoDoneEvent(id: item.id));

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(
        bloc: controller,
        builder: (context, state) => PageView(
          controller: _pageViewController,
          children: <Widget>[
            TaskScreen(
              itemList: (state as TodoDefaultState).items.where((element) => !element.isDone).toList(),
              onAddItem: onAddItem,
              onCompleteItem: onDoneItem,
              onRemoveItem: onRemoveItem,
            ),
            DoneScreen(
              itemList: state.items.where((element) => element.isDone).toList(),
              onRemoveItem: onRemoveItem,
              onResetItem: onDoneItem,
            )
          ],
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          _pageViewController.animateToPage(
            _selectedIndex,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: 'Pendentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Concluídas',
          ),
        ],
      ),
    );
  }
}
