import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

class TrainerRegister extends StatefulWidget {
  @override
  _TrainerRegisterState createState() => _TrainerRegisterState();
}

class _TrainerRegisterState extends State<TrainerRegister> {
  Trainer currentTrainer;

  double _privateSessionPrice;

  TypeOfExercise(String type) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.black12,
          border: Border.all(color: Colors.grey)),
      child: FlatButton(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(
            type,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
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
    _privateSessionPrice = 0;
    getCurrentTrainer();
    super.initState();
  }

  void getCurrentTrainer() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot trainerData = await Firestore.instance
        .collection('trainers')
        .document(getUser.uid)
        .get();
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
    } else {
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
                                  border: InputBorder.none),
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
                    width: MediaQuery.of(context).size.width - 20,
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
                          for (int i = 0; i < _type.length; i++)
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
                              ));
                    },
                    child: Text('Select Type of Exercise'),
                  ),
                  Text(
                    'Private Session Price (per hour): ${double.parse(_privateSessionPrice.toStringAsFixed(2))}',
                  ),
                  Container(
                    width: 300,
                    child: Slider(
                      value: _privateSessionPrice,
                      onChanged: (_input) {
                        setState(() {
                          _privateSessionPrice = _input;
                        });
                      },
                      min: 0,
                      max: 150,
                    ),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    child: Text('Continue'),
                    onPressed: () async {
                      final _user = await FirebaseAuth.instance.currentUser();
                      String _uid = _user.uid;
                      if (_type != null && _desc != null) {
                        if (_desc.text == '' || _desc.text == null) {
                          _desc = TextEditingController(
                              text: currentTrainer.description);
                        }
                        Firestore.instance
                            .collection('trainers')
                            .document(_uid)
                            .updateData({
                          'trainingTypes': _type,
                          'rating': 0,
                          'description': _desc.text,
                          'oneOnOnePrice': _privateSessionPrice,
                        });
                        if (currentTrainer.description != '') {
                          Navigator.pop(context);
                        } else {
                          _pay();
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

  void _pay() {
    InAppPayments.setSquareApplicationId(
        '***REMOVED***');
    InAppPayments.startCardEntryFlow(
      onCardNonceRequestSuccess: _onCardNonceRequestSuccess,
      onCardEntryCancel: _onCardEntryCancel,
    );
  }

  void _onCardEntryCancel() {}
  void _onCardNonceRequestSuccess(CardDetails result) {
    try {
      currentTrainer.reference.updateData({'cardNonce': result.nonce});
      InAppPayments.completeCardEntry(
        onCardEntryComplete: _cardEntryComplete,
      );
    } on Exception catch (ex) {
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  void _cardEntryComplete() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePic()),
    );
  }
}
