import 'dart:collection';
import 'package:flutter/material.dart';
import 'task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:confetti/confetti.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];
  final ConfettiController confettiController =
      ConfettiController(duration: Duration(seconds: 1));
  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  TaskData() {
    _initialize(); // Load saved tasks when the provider initializes
  }
  int get tasksCount {
    return _tasks.length;
  }

  void addTask(String taskTitle) {
    _tasks.add(Task(name: taskTitle));
    saveTasks();
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void deleteTask(DateTime identifier) {
    _tasks.removeWhere((task) => task.id == identifier);
    saveTasks();
    notifyListeners();
  }

  void renameTask(DateTime identifier, String newTitle) {
    final task = _tasks.firstWhere((task) => task.id == identifier);
    task.name = newTitle;
    saveTasks();
    notifyListeners();
  }

  void _initialize() async {
    await _loadTasks(); // Now we can use await here
    notifyListeners(); // Update the UI after loading
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      final List<dynamic> tasksJson = jsonDecode(tasksString);
      _tasks = tasksJson.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksString =
        jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksString);
  }
}
