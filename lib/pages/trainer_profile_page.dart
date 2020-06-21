import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/pages/price.dart';
import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';
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
          RaisedButton(
            child: Text('Change Profile Picture'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (ProfilePic())),
              );
            },
          ),
          RaisedButton(
            child: Text('Change Bio and Type'),
            onPressed:  () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (TrainerRegister())),
              );
            },
          ),
          RaisedButton(
            child: Text('Change Price of Your Videos'),
            onPressed:  () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (PricePage())),
              );
            },
          ),
        ],
      ),
    );
  }
}
