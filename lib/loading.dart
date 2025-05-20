import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_55th/screens/Home.dart';
import 'package:flutter_55th/todo_class.dart';

class LoadingData extends StatefulWidget {
  const LoadingData({super.key});

  @override
  State<LoadingData> createState() => _LoadingDataState();
}

class _LoadingDataState extends State<LoadingData> {
  @override
  void initState() {
    TodoList().getTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
