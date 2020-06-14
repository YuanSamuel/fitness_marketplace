import 'package:fitnessmarketplace/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _isTrainer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          FlatButton(
            color: Colors.blue,
            child: Text('Login'),
            onPressed: () async {
              print("Attempt Login");
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _email.text, password: _password.text)
                  .then((currentUser) {
                    if (_isTrainer) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrainerHomeScreen()),
                      );
                    }
              });
              print('Logged in ' + _email.text + ' as User ID ' + userid);
            },
          ),
          FlatButton(
            color: Colors.blue,
            child: Text('Register'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (Register())),
              );
            },
          ),
        ],
      ),
    );
  }
}
