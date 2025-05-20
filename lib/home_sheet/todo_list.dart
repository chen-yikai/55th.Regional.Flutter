import 'package:flutter/material.dart';
import 'package:flutter_55th/todo_class.dart';

class TodoListSheet extends StatefulWidget {
  final Function() addTodo;
  final DraggableScrollableController bottomSheetController;

  const TodoListSheet(
      {super.key, required this.addTodo, required this.bottomSheetController});

  @override
  State<TodoListSheet> createState() => _TodoListSheetState();
}

class _TodoListSheetState extends State<TodoListSheet> {
  var todos = TodoList().todos;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "任務列表",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(onPressed: () {
              widget.addTodo();
              widget.bottomSheetController.animateTo(
                  1, duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }, icon: Icon(Icons.add))
          ],
        ),
        Expanded(
          child: ReorderableListView.builder(
              itemBuilder: (context, index) {
                final item = todos[index];
                return Padding(
                  key: ValueKey(item.id),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: ValueKey(item.id),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: TodoList().colors[item.color],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                           timeFormatter(TodoList().todos[index].time),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: todos.length,
              onReorder: (a, b) {}),
        ),
      ],
    );
  }
}
