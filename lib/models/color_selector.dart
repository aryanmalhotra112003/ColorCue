import 'package:flutter/material.dart';

Color colorSelector(int taskCount) {
  if (taskCount >= 0 && taskCount <= 5) {
    return Color(0xFF00FF7F);
  } else if (taskCount > 5 && taskCount <= 10) {
    return Color(0xFFADFF2F);
  } else if (taskCount > 10 && taskCount <= 15) {
    return Color(0xFFFFEB3B);
  } else if (taskCount > 15 && taskCount <= 20) {
    return Color(0xFFFFD700);
  } else if (taskCount > 20 && taskCount <= 25) {
    return Color(0xFFFFA500);
  } else if (taskCount > 25 && taskCount <= 30) {
    return Color(0xFFFF8C00);
  } else if (taskCount > 30 && taskCount <= 35) {
    return Color(0xFFFF4500);
  } else if (taskCount > 35 && taskCount <= 40) {
    return Color(0xFFFF0000);
  } else if (taskCount > 40 && taskCount <= 50) {
    return Color(0xFF8B0000);
  } else if (taskCount > 50 && taskCount <= 65) {
    return Color(0xFF800080);
  } else if (taskCount > 65 && taskCount <= 80) {
    return Color(0xFF4B0082);
  } else {
    return Color(0xFF000000);
  }
}
