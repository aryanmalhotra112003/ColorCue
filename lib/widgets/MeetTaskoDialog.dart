import 'package:flutter/material.dart';

class MeetTaskoDialog extends StatelessWidget {
  MeetTaskoDialog({required this.newColor});
  Color newColor;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: newColor.withOpacity(0.85),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/wave.png', height: 120),
            SizedBox(height: 10),
            Text(
              "Hi! I’m Tasko 🐶",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Your productivity pup. I’ll cheer you on, keep you focused, and celebrate when you check things off!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            TextButton(
              style:
                  TextButton.styleFrom(side: BorderSide(color: Colors.white)),
              onPressed: () => Navigator.pop(context),
              child: Text("Let's get to work",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
