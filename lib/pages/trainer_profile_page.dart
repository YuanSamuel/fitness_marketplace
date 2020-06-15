import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RaisedButton(
            child: Text('Sign Out'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popAndPushNamed(context, '/register');
            },
          ),
        ],
      ),
    );
  }
}
