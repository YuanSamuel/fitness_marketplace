import 'package:fitnessmarketplace/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register.dart';

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
          FlatButton(
            color: Colors.blue,
            child: Text('Login'),
            onPressed: () {
              print("Attempt Login");
                FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text).then(
                        (currentUser) {
                      Firestore.instance.collection('users').document(currentUser.user.uid).get().then(
                              (value) {
                            userid = currentUser.user.uid;
                            //To Home Page
                          });
                    }
                );
                print('Logged in '+_email.text+' as User ID '+userid);
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
