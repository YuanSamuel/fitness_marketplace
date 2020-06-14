import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'register.dart';

class TrainerRegister extends StatefulWidget {
  @override
  _TrainerRegisterState createState() => _TrainerRegisterState();
}

class _TrainerRegisterState extends State<TrainerRegister> {

  List<String> _type = new List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(_type.toString()),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Scaffold(
                    body: SelectDialog(
                      itemsList: ['Running', 'Martial Arts', 'Cardio', 'Lifting', 'Yoga'],
                      onChange: (String selected) {
                        setState(() {
                          bool hasSelected = false;
                          for(int i=0;i<_type.length;i++){
                            if(selected==_type[i]){
                              hasSelected = true;
                            }
                          }
                          if(!hasSelected){
                            _type.add(selected);
                          }
                        });
                      },
                    ),
                  )
                );
              },
              child: Text('Select Type'),
            ),
            FlatButton(
              color: Colors.blue,
              child: Text('Continue'),
              onPressed: () {
                Firestore.instance.collection('trainers').document(userid).setData({
                  'type': _type,
                  'rating': 0,
                },merge: true);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePic()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
