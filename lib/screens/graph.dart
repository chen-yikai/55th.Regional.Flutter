import 'package:flutter/material.dart';
import 'package:flutter_55th/painter/graph_painter.dart';
import 'package:flutter_55th/todo_class.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen>
    with SingleTickerProviderStateMixin {
  late List<Todo> todoHistory;
  var totalTime = 0;
  var maxTime = 0;
  late AnimationController controller;
  List<int> preDay = List.filled(7, 0, growable: true);

  Future<void> setTodoHistory() async {
    todoHistory = await TodoList().getHistory();
    totalTime = 0;
    preDay = List.filled(7, 0, growable: true);
    for (var item in todoHistory) {
      totalTime += item.time;
    }

    for (int i = 0; i < 7; i++) {
      preDay[i] = todoHistory
          .where((a) => a.day == i + 1)
          .fold(0, (sum, item) => sum + item.time);
    }

    maxTime = preDay.reduce((a, b) => a > b ? a : b);

    setState(() {});
  }

  @override
  void initState() {
    setTodoHistory();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();
    controller.addListener(() {
      print(controller.value);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("數據分析")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  "每週工作時間",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: 400,
              height: 400,
              // color: Colors.lightBlue,
              child: CustomPaint(
                painter: GraphPainter(
                    preDay: preDay, maxTime: maxTime, controller: controller.value),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "總時長",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "${(totalTime / 60).round()}分鐘",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
