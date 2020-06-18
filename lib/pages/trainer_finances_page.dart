import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:flutter/material.dart';

class TrainerFinancesPage extends StatefulWidget {
  TrainerFinancesPage({Key key}) : super(key: key);

  @override
  _TrainerFinancesPageState createState() => _TrainerFinancesPageState();
}

class _TrainerFinancesPageState extends State<TrainerFinancesPage> {

  Trainer currentTrainer;
  List<RecordedVideo> trainerVideos;
  List<PrivateSession> trainerPrivateSessions;
  

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance.collection('trainers').document(getUser.uid).get();
    currentTrainer = Trainer.fromSnapshot(userData);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}