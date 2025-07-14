import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:colorcue/widgets/task_list.dart';
import 'add_task_screen.dart';
import 'package:colorcue/models/task_data.dart';
import 'package:colorcue/models/color_selector.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';
import 'package:colorcue/models/mood_selector.dart';
import 'package:colorcue/widgets/MeetTaskoDialog.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late Color _currentColor;
  late int _previousTaskCount;

  @override
  void initState() {
    super.initState();

    _previousTaskCount =
        Provider.of<TaskData>(context, listen: false).tasksCount;
    _currentColor = colorSelector(_previousTaskCount);
  }

  @override
  Widget build(BuildContext context) {
    final taskCount = Provider.of<TaskData>(context).tasksCount;

    final newColor = colorSelector(taskCount);

    if (_previousTaskCount != taskCount) {
      _previousTaskCount = taskCount;
    }

    return Stack(
        alignment: Alignment.topCenter, //for confetti
        children: [
          TweenAnimationBuilder<Color?>(
            tween: ColorTween(begin: _currentColor, end: newColor),
            duration: Duration(seconds: 2),
            curve: Curves.decelerate,
            onEnd: () {
              _currentColor = newColor;
            },
            builder: (context, animatedColor, child) {
              return Scaffold(
                backgroundColor: animatedColor,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: animatedColor,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddTaskScreen(),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 60, left: 30, right: 30, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  12), // set to 0 for perfect square
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      MeetTaskoDialog(newColor: newColor),
                                );
                              },
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: Lottie.asset(
                                  moodSelector(taskCount),
                                  key: ValueKey(moodSelector(taskCount)),
                                  height: 150,
                                  width: 150,
                                  repeat: true,
                                  animate: true,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'ColorCue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '$taskCount tasks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: TasksList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ConfettiWidget(
            confettiController:
                Provider.of<TaskData>(context).confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 15,
            emissionFrequency: 0.02,
            gravity: 0.7,
          ),
        ]);
  }
}
