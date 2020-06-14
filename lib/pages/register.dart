import 'package:fitnessmarketplace/pages/trainer_register.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

String userid;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _isTrainer = false;

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
                _isTrainer = false;
              }
              else{
                _isTrainer = true;
              }
              print('Trainer is '+_isTrainer.toString());
            }
          ),
          FlatButton(
            color: Colors.blue,
            child: Text('Register'),
            onPressed: () {
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text).then((currentUser) {
                Firestore.instance.collection('users').document(currentUser.user.uid).setData({
                  'name': _name.text,
                  'uid': currentUser.user.uid,
                  'email': _email.text,
                  'istrainer': _isTrainer,
                });
                userid = currentUser.user.uid;
                if(_isTrainer==true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerRegister()),
                  );
                }
                else{
                  //To Home Page
                }
              });
              print('Registered '+_email.text+' as User ID '+userid);
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
