import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_55th/bottomSheet.dart';
import 'package:flutter_55th/painter/clock_painter.dart';
import 'package:flutter_55th/screens/graph.dart';
import 'package:flutter_55th/todo_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const platform = MethodChannel('dev.eliaschen.tomatobo');

  late Timer timer;
  int seconds = TodoList().todos.first.time;
  bool isPause = true;
  bool done = true;
  bool repeatVibrate = false;

  late AnimationController shakeAnimationController;
  late Animation<double> shakeAnimation;

  @override
  void initState() {
    super.initState();
    shakeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1 * pi / 180),
        weight: 25, // 100ms
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1 * pi / 180, end: 0),
        weight: 25, // 100ms
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -1 * pi / 180),
        weight: 25, // 100ms
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -1 * pi / 180, end: 0),
        weight: 25, // 100ms
      ),
    ]).animate(CurvedAnimation(
      parent: shakeAnimationController,
      curve: Curves.linear,
    ));
  }

  Future<void> vibrate() async {
    repeatVibrate = true;
    while (repeatVibrate) {
      await platform.invokeMethod('vibrate');
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void startTimer() {
    shakeAnimationController.reset();
    repeatVibrate = false;
    setState(() {
      isPause = false;
      done = false;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          TodoList().todos.removeAt(0);
          setState(() {
            done = true;
            isPause = true;
          });
          shakeAnimationController.repeat();
          vibrate();
          timer.cancel();
          seconds = TodoList().todos.first.time;
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isPause = true;
      done = false;
    });
    timer.cancel();
  }

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
      body:  Container(
              color: Color(0xffF9F9F9),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotationTransition(
                      turns: shakeAnimation,
                      child: Container(
                        width: 250,
                        height: 250,
                        child: CustomPaint(painter: ClockPainter(sec: seconds)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "鬧鐘",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      timeFormatter(seconds),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () async {
                                if (done || isPause) {
                                  startTimer();
                                } else {
                                  pauseTimer();
                                }
                              },
                              child: Text(
                                !done
                                    ? !isPause
                                        ? "暫停"
                                        : "繼續"
                                    : "開始",
                                style: TextStyle(fontSize: 20),
                              ),
                              style: FilledButton.styleFrom(
                                  backgroundColor: isPause
                                      ? Color(0xffEDCB77)
                                      : Color(0xff579ECF),
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
            )
         ,
    );
  }
}
