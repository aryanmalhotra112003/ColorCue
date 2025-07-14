import 'package:flutter/material.dart';
import 'color_selector.dart';
import 'package:provider/provider.dart';
import 'task_data.dart';

void showRenameDialog(BuildContext context, String currentTitle, int taskCount,
    DateTime identifier) {
  TextEditingController con = TextEditingController();
  con.text = currentTitle;
  final titleStyle = Theme.of(context)
      .textTheme
      .headlineSmall
      ?.copyWith(fontWeight: FontWeight.bold, color: colorSelector(taskCount));

  void showError() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titleTextStyle: titleStyle,
            contentTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                ),
            title: Text(
              'Error',
              style: TextStyle(fontSize: 25),
            ),
            content: Text(
              'Field left blank!',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorSelector(taskCount),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titleTextStyle: titleStyle,
          title: Text('Rename Task'),
          content: TextField(
            controller: con,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter new task name',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorSelector(taskCount),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  final newTitle = con.text.trim();
                  if (newTitle.isNotEmpty) {
                    Provider.of<TaskData>(context, listen: false)
                        .renameTask(identifier, newTitle);
                    Navigator.of(context).pop();
                  } else {
                    showError();
                  }
                },
                child: Text('Rename'))
          ],
        );
      });
}
