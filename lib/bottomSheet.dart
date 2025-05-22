import 'package:flutter/material.dart';
import 'package:flutter_55th/home_sheet/add_todo.dart';
import 'package:flutter_55th/home_sheet/todo_list.dart';

class HomeBottomsheet extends StatefulWidget {
  final VoidCallback homeCallBack;

  const HomeBottomsheet({super.key, required this.homeCallBack});

  @override
  State<HomeBottomsheet> createState() => _HomeBottomsheetState();
}

class _HomeBottomsheetState extends State<HomeBottomsheet>
    with SingleTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<Offset> fadeAnimation;
  late Animation<Offset> todoListSlideAnimation;
  final bottomSheetController = DraggableScrollableController();
  final GlobalKey<AddTodoListState> _addTodoKey = GlobalKey<AddTodoListState>();
  bool isList = false;

  @override
  void initState() {
    fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    fadeAnimation = Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: fadeController, curve: Curves.easeInOut));

    todoListSlideAnimation = Tween(begin: Offset(0, 0), end: Offset(-1, 0))
        .animate(
            CurvedAnimation(parent: fadeController, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        controller: bottomSheetController,
        expand: false,
        minChildSize: 0.2,
        initialChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scroller) {
          return SingleChildScrollView(
            controller: scroller,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Stack(
                      children: [
                        SlideTransition(
                          position: todoListSlideAnimation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TodoListSheet(
                              addTodo: () {
                                fadeController.forward();
                                _addTodoKey.currentState?.clearInput();
                                setState(() {
                                  isList = false;
                                });
                              },
                              bottomSheetController: bottomSheetController,
                              homeCallBack: widget.homeCallBack,
                            ),
                          ),
                        ),
                        if (!isList)
                          SlideTransition(
                            position: fadeAnimation,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AddTodoList(
                                  key: _addTodoKey,
                                  goBack: () async {
                                    fadeController.reverse();
                                    await bottomSheetController.animateTo(0.2,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                    _addTodoKey.currentState?.clearInput();
                                    setState(() {
                                      isList = true;
                                    });
                                  },
                                  reload: () {
                                    widget.homeCallBack();
                                  },
                                  bottomSheetController: bottomSheetController,
                                )),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
