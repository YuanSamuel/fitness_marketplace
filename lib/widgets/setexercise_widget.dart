import 'package:flutter/material.dart';

class SetExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      height: 200.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black54
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Enter Exercise Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white
                    ),
                  ),
                  focusColor: Colors.white,
                ),
              ),
            ),
            Text('Reps', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.white,),
                  onPressed: (){},
                ),
                Text('1', style: TextStyle(color: Colors.white),),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.white,),
                  onPressed: (){},
                ),
              ],
            ),
            Text('Minutes', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.white,),
                  onPressed: (){},
                ),
                Text('1', style: TextStyle(color: Colors.white),),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.white,),
                  onPressed: (){},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
