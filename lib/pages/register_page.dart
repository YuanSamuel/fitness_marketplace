import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

String userid;
bool isTrainer = false;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;

  @override
  void initState() {
    _firstNameInputController = new TextEditingController();
    _lastNameInputController = new TextEditingController();
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _firstNameInputController,
            decoration: InputDecoration(
              hintText: 'First Name',
            ),
          ),
          TextField(
            controller: _lastNameInputController,
            decoration: InputDecoration(
              hintText: 'Last Name',
            ),
          ),
          TextField(
            controller: _emailInputController,
            decoration: InputDecoration(
                hintText: 'Email',
            ),
          ),
          TextField(
            controller: _passwordInputController,
            decoration: InputDecoration(
                hintText: 'Password',
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
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailInputController.text, password: _passwordInputController.text).then((currentUser) async {
                if (isTrainer) {
                  await Firestore.instance.collection('trainers').document(currentUser.user.uid).setData({
                    'firstName': _firstNameInputController.text,
                    'lastName': _lastNameInputController.text,
                    'uid': currentUser.user.uid,
                    'email': _emailInputController.text,
                    'rating': 0.0,
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerHomeScreen()),
                  );
                }
                else {
                  Firestore.instance.collection('students').document(currentUser.user.uid).setData({
                    'firstName': _firstNameInputController.text,
                    'lastName': _lastNameInputController.text,
                    'uid': currentUser.user.uid,
                    'email': _emailInputController.text,
                  });
                }
                userid = currentUser.user.uid;
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
