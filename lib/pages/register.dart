import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

String userid;
bool isTrainer = false;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  void initState() {
    _name = new TextEditingController();
    _email = new TextEditingController();
    _password = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(
              hintText: 'Full Name'
            ),
          ),
          TextField(
            controller: _email,
            decoration: InputDecoration(
                hintText: 'Email'
            ),
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(
                hintText: 'Password'
            ),
          ),
          ToggleSwitch(
            minWidth: 90.0,
            cornerRadius: 20,
            activeBgColor: Colors.green,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveTextColor: Colors.white,
            labels: ['Student', 'Trainer'],
            activeColors: [Colors.blue, Colors.green],
            onToggle: (index) {
              if(index==0){
                isTrainer = false;
              }
              else{
                isTrainer = true;
              }
              print('Trainer is '+isTrainer.toString());
            }
          ),
          FlatButton(
            color: Colors.blue,
            child: Text('Register'),
            onPressed: () {
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text).then((currentUser) {
                if(isTrainer){
                  Firestore.instance.collection('trainers').document(currentUser.user.uid).setData({
                    'name': _name.text,
                    'uid': currentUser.user.uid,
                    'email': _email.text,
                  });
                }
                else{
                  Firestore.instance.collection('users').document(currentUser.user.uid).setData({
                    'name': _name.text,
                    'uid': currentUser.user.uid,
                    'email': _email.text,
                  });
                }
                userid = currentUser.user.uid;
                if(isTrainer==true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerRegister()),
                  );
                }
                else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePic()),
                  );
                }
              });
            },
          ),
          FlatButton(
            color: Colors.blue,
            child: Text('Login'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (Login())),
              );
            },
          ),
        ],
      ),
    );
  }
}
