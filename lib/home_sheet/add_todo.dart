import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_55th/todo_class.dart';

class AddTodoList extends StatefulWidget {
  final Function() goBack;
  final DraggableScrollableController bottomSheetController;

  const AddTodoList(
      {super.key, required this.goBack, required this.bottomSheetController});

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {
  final TextEditingController nameController = TextEditingController(),
      minutes = TextEditingController(),
      seconds = TextEditingController();
  var selectedColor = 0;
  var isWork = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  widget.goBack();
                },
                icon: Icon(Icons.arrow_back_ios)),
            Text(
              "新增任務",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("類別", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  DropdownMenu(
                      onSelected: (item) {
                        setState(() {
                          isWork = item == 0;
                        });
                      },
                      initialSelection: 0,
                      width: double.infinity,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 0, label: "工作"),
                        DropdownMenuEntry(value: 1, label: "休息"),
                      ]),
                  SizedBox(height: 20),
                  Text("名稱", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "請輸入名稱", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  Text("時間長度", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minutes,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "分鐘", border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: seconds,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "秒數", border: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("顏色", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: TodoList().colors.asMap().entries.map((item) {
                        final color = item.value;
                        final index = item.key;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(10)),
                              child: selectedColor == index
                                  ? Icon(Icons.check)
                                  : SizedBox(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: FilledButton(
                          style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            final id = Random().nextInt(10000000);
                            final time =
                                (int.tryParse(minutes.text) ?? 0) * 60 +
                                    (int.tryParse(seconds.text) ?? 0);

                            TodoList().todos.add(Todo(
                                id: id,
                                name: nameController.text,
                                isWork: isWork,
                                time: time,
                                color: selectedColor,
                                day: 0));
                            TodoList().writeTodoList();
                            widget.goBack();
                          },
                          child: Text(
                            "新增",
                          ))),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
