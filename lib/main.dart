import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_55th/screens/Home.dart';
import 'package:flutter_55th/todo_class.dart';

void main() {
  runApp(const Entry());
}

class Entry extends StatefulWidget {
  const Entry({super.key});

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
