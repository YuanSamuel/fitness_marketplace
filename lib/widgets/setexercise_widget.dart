import 'package:flutter/material.dart';

class SetExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.blue
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(

            ),
            Text('## reps', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
            Text('## minutes', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
