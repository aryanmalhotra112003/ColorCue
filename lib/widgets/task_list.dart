import 'package:colorcue/models/showRenameDialog.dart';
import 'package:colorcue/screens/timer_screen.dart';
import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:colorcue/models/task_data.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        final reversedTasks = taskData.tasks.reversed.toList();
        return ListView.builder(
          reverse: false,
          itemBuilder: (context, index) {
            final task = reversedTasks[index];
            return TaskTile(
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyTimer(
                      title: task.name,
                      id: task.id,
                    ),
                  ),
                );
              },
              taskTitle: task.name,
              onTap: () {
                taskData.deleteTask(task.id);
                Provider.of<TaskData>(context, listen: false)
                    .confettiController
                    .play();
              },
              onTapRename: () {
                showRenameDialog(
                    context, task.name, taskData.tasksCount, task.id);
              },
              id: task.id,
            );
          },
          itemCount: reversedTasks.length,
        );
      },
    );
  }
}
