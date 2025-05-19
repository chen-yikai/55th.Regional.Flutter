import 'package:flutter/material.dart';

class AddTodoList extends StatefulWidget {
  final Function() goBack;

  const AddTodoList({super.key, required this.goBack});

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: widget.goBack, icon: Icon(Icons.arrow_back_ios)),
            Text("新增任務")
          ],
        )
      ],
    );
  }
}
