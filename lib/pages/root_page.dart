import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/pages/register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  FirebaseUser currentUser;
  bool doneLoading;
  bool isTrainer;

  @override
  void initState() {
    doneLoading = false;
    isTrainer = false;
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser != null) {
      DocumentSnapshot userData = await Firestore.instance.collection('users').document(currentUser.uid).get();
      isTrainer = userData.data['isTrainer'];
    }
    setState(() {
      doneLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!doneLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else {
      if (currentUser == null) {
        return Register();
      }
      else {
        if (isTrainer) {
          return TrainerNavigation();
        }
        else {
          return UserNavigation();
        }
      }
    }
  }
}