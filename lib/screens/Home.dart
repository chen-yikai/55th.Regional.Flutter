import 'package:flutter/material.dart';
import 'package:flutter_55th/bottomSheet.dart';
import 'package:flutter_55th/painter/clock_painter.dart';
import 'package:flutter_55th/screens/graph.dart';
import 'package:flutter_55th/todo_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: HomeBottomsheet(),
      appBar: AppBar(
        title: Text("Tomato Bo", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => GraphScreen()));
              },
              icon: const Icon(Icons.auto_graph))
        ],
      ),
      body: Container(
        color: Color(0xffF9F9F9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                child: CustomPaint(painter: ClockPainter(sec: 30)),
              ),
              const SizedBox(height: 20),
              const Text(
                "鬧鐘",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
               timeFormatter(TodoList().todos.first.time),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {},
                        child: Text("開始"),
                        style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
