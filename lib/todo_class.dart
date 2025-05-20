import 'dart:ui';

class TodoList {
  TodoList._internal();

  static final TodoList _instance = TodoList._internal();

  factory TodoList() => _instance;

  List<Todo> todos = [
    Todo(id: 0, name: "Feed my cat", isWork: true, time: 30, color: 0, day: 0),
    Todo(id: 1, name: "Coding", isWork: false, time: 20, color: 2, day: 2)
  ];
  List<Color> colors = [
    Color(0xffEDCB77),
    Color(0xff63C1BD),
    Color(0xffE4645B),
    Color(0xff92ACE5),
    Color(0xff5595C4),
    Color(0xff579ECF)
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

String timeFormatter(int seconds){
  final mm = (seconds ~/ 60).toString().padLeft(2,"0");
  final ss = (seconds % 60).toString().padLeft(2,"0");
  return "$mm:$ss";
}