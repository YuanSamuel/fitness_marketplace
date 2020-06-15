import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'register_page.dart';

class TrainerRegister extends StatefulWidget {
  @override
  _TrainerRegisterState createState() => _TrainerRegisterState();
}

class _TrainerRegisterState extends State<TrainerRegister> {

  TypeOfExercise(String type){
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.black12,
        border: Border.all(color: Colors.grey)
      ),
      child: FlatButton(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(type,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black
            ),
          ),
        ),
        onPressed: () {
          _type.remove(type);
          setState(() {
            TrainerRegister();
          });
        },
      ),
    );
  }

  TextEditingController _desc = new TextEditingController();
  List<String> _type = new List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ListView(
                        children: [
                          TextField(
                            controller: _desc,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: -20),
                                hintText: 'Tell us about yourself',
                                border: InputBorder.none
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ],
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width-20,
                  height: 400,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: [
                        for(int i=0;i<_type.length;i++)
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: TypeOfExercise(_type[i]),
                          ),
                      ],
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                Container(
                  height: 5,
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => Scaffold(
                          body: SelectDialog(
                            itemsList: ['Running', 'Martial Arts', 'Cardio', 'Weight Lifting', 'Yoga'],
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
                      'desc': _desc,
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
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
