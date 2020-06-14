import 'package:fitnessmarketplace/pages/register_page.dart';
import 'package:fitnessmarketplace/pages/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

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
                  .then((currentUser) async {
                    print(currentUser.user.uid);
                    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(currentUser.user.uid).get();
                    print(snapshot.data);
                    if (snapshot.data['isTrainer']) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrainerHomePage()),
                      );
                    }
                    else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserHomePage()),
                      );
                    }
              });
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
