import 'package:flutter/material.dart';
import 'package:colorcue/widgets/hero_text.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {super.key,
      required this.onLongPress,
      required this.taskTitle,
      required this.onTap,
      required this.onTapRename,
      required this.id});
  final Function()? onLongPress;
  final Function()? onTap;
  final Function()? onTapRename;
  final String taskTitle;
  final DateTime id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      onTap: onTapRename,
      title: SharedHeroTitle(
        size: 17,
        text: taskTitle,
        id: id,
        color: Colors.black,
      ),
      trailing: IconButton(onPressed: onTap, icon: Icon(Icons.delete)),
    );
  }
}
