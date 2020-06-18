import 'package:fitnessmarketplace/pages/price.dart';
import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';

class TrainerRegister extends StatefulWidget {

  @override
  _TrainerRegisterState createState() => _TrainerRegisterState();
}

class _TrainerRegisterState extends State<TrainerRegister> {

  Trainer currentTrainer;

  TypeOfExercise(String type) {
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
  List _type = new List();

  @override
  void initState() {
    getCurrentTrainer();
    super.initState();
  }

  void getCurrentTrainer() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot trainerData = await Firestore.instance.collection(
        'trainers').document(getUser.uid).get();
    currentTrainer = Trainer.fromSnapshot(trainerData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (currentTrainer == null) {
      TrainerRegister();
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    else {
      _type = currentTrainer.trainingTypes;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 20,
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
                          for(int i = 0; i < _type.length; i++)
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
                          builder: (_) =>
                              Scaffold(
                                body: SelectDialog(
                                  itemsList: [
                                    'Running',
                                    'Martial Arts',
                                    'Cardio',
                                    'Weight Lifting'
                                  ],
                                  onChange: (String selected) {
                                    setState(() {
                                      bool hasSelected = false;
                                      for (int i = 0; i < _type.length; i++) {
                                        if (selected == _type[i]) {
                                          hasSelected = true;
                                        }
                                      }
                                      if (!hasSelected) {
                                        _type.add(selected);
                                      }
                                    });
                                  },
                                ),
                              )
                      );
                    },
                    child: Text('Select Type of Exercise'),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    child: Text('Continue'),
                    onPressed: () async {
                      final _user = await FirebaseAuth.instance.currentUser();
                      String _uid = _user.uid;
                      if (_type != null && _desc != null) {
                        if (_desc.text == '' || _desc.text == null) {
                          _desc = TextEditingController(text: currentTrainer
                              .description);
                        }
                        Firestore.instance.collection('trainers')
                            .document(_uid)
                            .setData({
                          'trainingTypes': _type,
                          'rating': 0,
                          'description': _desc.text,
                        }, merge: true);
                        if (currentTrainer.description != '') {
                          Navigator.pop(context);
                        }
                        else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                PricePage()),
                          );
                        }
                      }
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
}