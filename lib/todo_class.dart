import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class TodoList {
  static const platform = MethodChannel('dev.eliaschen.tomatobo');

  void writeTodoList() {
    final List<Map<String, dynamic>> jsonList =
        TodoList().todos.map((item) => item.toJson()).toList();
    platform.invokeMethod("writeCurrentTodo", {"data": jsonEncode(jsonList)});
  }

  Future<List<Todo>> getHistory() async {
    final data = await platform.invokeMethod("getHistory");
    final List<dynamic> json = await jsonDecode(data);
    final jsonList = json
        .map((item) => Todo.fromJson(item as Map<String, dynamic>))
        .toList();
    return jsonList;
  }

  void writeHistory(Todo item) async {
    final List<Todo> historyList = await getHistory();
    historyList.add(item);
    platform.invokeMethod("writeHistory", {
      "data": jsonEncode(historyList.map((item) => item.toJson()).toList())
    });
  }

  TodoList._internal();

  static final TodoList _instance = TodoList._internal();

  factory TodoList() => _instance;

  List<Todo> todos = [];

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
  int day;

  Todo(
      {required this.id,
      required this.name,
      required this.isWork,
      required this.time,
      required this.color,
      required this.day});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isWork': isWork,
        'time': time,
        'color': color,
        'day': day
      };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as int,
      name: json['name'] as String,
      isWork: json['isWork'] as bool,
      time: json['time'] as int,
      color: json['color'] as int,
      day: json['day'] as int);
}

String timeFormatter(int seconds) {
  final mm = (seconds ~/ 60).toString().padLeft(2, "0");
  final ss = (seconds % 60).toString().padLeft(2, "0");
  return "$mm:$ss";
}
