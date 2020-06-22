import 'package:flutter/material.dart';

class CurrentExerciseWidget extends StatelessWidget {


  final String name;
  final int reps;
  final int mins;

  const CurrentExerciseWidget({Key key, this.name, this.reps, this.mins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black87
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w600),),
            Text(reps.toString()+' reps', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
            Text(mins.toString()+' minutes', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
