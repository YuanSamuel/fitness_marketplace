import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validators/sanitizers.dart';
import 'profile_picture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';

class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {

  Trainer currentTrainer;

  @override
  void initState() {
    getCurrentTrainer();
    super.initState();
  }

  void getCurrentTrainer() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot trainerData = await Firestore.instance.collection('trainers').document(getUser.uid).get();
    currentTrainer = Trainer.fromSnapshot(trainerData);
    setState(() {});
  }

  double _video = 0;
  double _live = 0;
  double _one = 0;

  @override
  Widget build(BuildContext context) {
    if(currentTrainer==null){
      PricePage();
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    else{
      return Scaffold(
        body: Column(
          children: [
            Text(
              'Select Your Price',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),
            ),
            Text(
              'Video Price (per video): ${double.parse(_video.toStringAsFixed(2))}',
            ),
            Container(
              width: 300,
              child: Slider(
                value: _video,
                onChanged: (_input) {
                  setState(() {
                    _video = _input;
                  });
                },
                min: 0,
                max: 150,
              ),
            ),
            Text(
              'Live Session Price (per hour): ${double.parse(_live.toStringAsFixed(2))}',
            ),
            Container(
              width: 300,
              child: Slider(
                value: _live,
                onChanged: (_input) {
                  setState(() {
                    _live = _input;
                  });
                },
                min: 0,
                max: 150,
              ),
            ),
            Text(
              'One on One Session Price (per hour): ${double.parse(_one.toStringAsFixed(2))}',
            ),
            Container(
              width: 300,
              child: Slider(
                value: _one,
                onChanged: (_input) {
                  setState(() {
                    _one = _input;
                  });
                },
                min: 0,
                max: 150,
              ),
            ),
            FlatButton(
              color: Colors.blue,
              child: Text('Continue'),
              onPressed: () async {
                final _user = await FirebaseAuth.instance.currentUser();
                String _uid = _user.uid;
                if(_video!=null&&_live!=null&&_one!=null) {
                  Firestore.instance.collection('trainers').document(_uid).setData({
                    'videoPrice': double.parse(_video.toStringAsFixed(2)),
                    'livePrice': double.parse(_live.toStringAsFixed(2)),
                    'oneOnOnePrice': double.parse(_one.toStringAsFixed(2)),
                  },merge: true);
                  if(currentTrainer.videoPrice!=0.0&&currentTrainer.livePrice!=0.0&&currentTrainer.oneOnOnePrice!=0.0){
                    Navigator.pop(context);
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePic()),
                    );
                  }
                }
              },
            ),
          ],
        ),
      );
    }
  }
}
