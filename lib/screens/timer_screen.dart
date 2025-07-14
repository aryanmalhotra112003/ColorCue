import 'package:flutter/material.dart';
import 'dart:async';
import 'package:colorcue/models/color_selector.dart';
import 'package:colorcue/models/task_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:colorcue/widgets/hero_text.dart';

class MyTimer extends StatefulWidget {
  MyTimer({super.key, required this.title, required this.id});
  final DateTime id;
  final String title;

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  double value = 1.0;
  int minutes = 25;
  int seconds = 0;

  final player = AudioPlayer();

  late int tasksCount;
  double percentComplete = 0.0;
  Color percentColor = Colors.white;

  Timer? timer;
  int remainingSeconds = 1500;

  @override
  void initState() {
    super.initState();
    tasksCount = Provider.of<TaskData>(context, listen: false).tasksCount;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (remainingSeconds <= 0) {
          timer.cancel();
          Future.delayed(Duration.zero, () async {
            await player.setReleaseMode(ReleaseMode.loop);
            await player.play(AssetSource('note1.wav'));
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shadowColor: colorSelector(tasksCount),
                    backgroundColor:
                        colorSelector(tasksCount).withOpacity(0.75),
                    title: Text(
                      "Time for a break",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    content: Text(
                      "See you back in 5!",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.white)),
                        onPressed: () async {
                          await player.stop();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  );
                });
          });
        } else {
          remainingSeconds--;
          updateTime(remainingSeconds);
        }
      });
    });
  }

  void updateTime(int remainingTime) {
    setState(() {
      minutes = (remainingTime % 3600) ~/ 60;
      seconds = remainingTime % 60;

      value = (remainingTime / 1500).toDouble();
      percentComplete = ((1 - value) * 100).toDouble();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey,
          title: SharedHeroTitle(
            size: 20,
            text: widget.title,
            id: widget.id,
            color: colorSelector(tasksCount),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: colorSelector(tasksCount).withOpacity(0.25),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      '${minutes.toString().padLeft(2, '0')} : '
                      '${seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 320,
                      width: 320,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 10, // Thicker for halo
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorSelector(tasksCount).withOpacity(0.15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorSelector(tasksCount),
                        ),
                      ),
                    ),
                    // Time Text
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        percentColor = percentColor.opacity == 1.0
                            ? Colors.white.withOpacity(0.0)
                            : Colors.white.withOpacity(1.0);
                      });
                    },
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 200),
                      style: TextStyle(fontSize: 30, color: percentColor),
                      child: Text("${percentComplete.toStringAsFixed(0)}%"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
