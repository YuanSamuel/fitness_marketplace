import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewRecording extends StatefulWidget {
  @override
  _AddNewRecordingState createState() => _AddNewRecordingState();
}

class _AddNewRecordingState extends State<AddNewRecording> {
  String dropdownValue = 'LiveStream';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.black87])),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  )
                ),
                SizedBox(width: 20),
                Text(
                    "Add a new session",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 32
                  ),
                ),

              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.grey[700],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 10.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              height: 500,
              width: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Session Type:",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic
                      ),),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        dropdownColor: Colors.grey,
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward,
                        color: Colors.black,),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['LiveStream', 'Video Recording']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 60,
              width: 120,
              child: FloatingActionButton(
                elevation: 20,
                child: Container(
                  child: Text("Submit",
                  style: TextStyle(
                    fontSize: 18
                  ),),
                ),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
