import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/tasks_screen.dart';
import 'models/task_data.dart';

void main() {
  runApp(ColorCue());
}

class ColorCue extends StatelessWidget {
  const ColorCue({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (BuildContext context) {
        return TaskData();
      },
      child: MaterialApp(
        home: TasksScreen(),
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black, // blinking caret
            selectionColor: Colors.black, // highlight background
            selectionHandleColor: Colors.black, // draggable dot handles
          ),
        ),
      ),
    );
  }
}
