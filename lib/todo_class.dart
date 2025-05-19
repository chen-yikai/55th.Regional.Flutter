class TodoList {
  TodoList._internal();

  static final TodoList _instance = TodoList._internal();

  factory TodoList() => _instance;

  List<Todo> todos = [
    Todo(id: 0, name: "Feed my cat", isWork: true, time: 30, color: 0, day: 0),
    Todo(id: 1, name: "Coding", isWork: false, time: 20, color: 10, day: 2)
  ];
}

class Todo {
  final int id;
  final String name;
  final bool isWork;
  final int time;
  final int color;
  final int day;

  Todo(
      {required this.id,
      required this.name,
      required this.isWork,
      required this.time,
      required this.color,
      required this.day});
}
