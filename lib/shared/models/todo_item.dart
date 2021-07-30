class ToDoItem {
  final String id;
  final String title;
  final bool isDone;

  ToDoItem({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  ToDoItem copyWith({String? id, String? title, bool? isDone}) {
    return ToDoItem(id: id ?? this.id, title: title ?? this.title, isDone: isDone ?? this.isDone);
  }
}
