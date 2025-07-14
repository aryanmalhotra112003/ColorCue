import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:colorcue/models/task_data.dart';
import 'package:provider/provider.dart';
import 'package:colorcue/models/color_selector.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController taskName = TextEditingController();
  @override
  void dispose() {
    taskName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isValid(String title) => title.trim().isNotEmpty;

    void showValidationError() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor:
              colorSelector(Provider.of<TaskData>(context).tasksCount),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Error',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Field left blank. Try again!',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          actions: [
            TextButton(
              style:
                  TextButton.styleFrom(side: BorderSide(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        color: Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: colorSelector(
                        Provider.of<TaskData>(context).tasksCount),
                    fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: taskName,
                  decoration: InputDecoration(
                    hintText: 'Add a task',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  autofocus: true,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: colorSelector(
                        Provider.of<TaskData>(context).tasksCount)),
                onPressed: () {
                  if (!isValid(taskName.text)) {
                    showValidationError();
                  } else {
                    Provider.of<TaskData>(context, listen: false)
                        .addTask(taskName.text);
                    taskName.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
