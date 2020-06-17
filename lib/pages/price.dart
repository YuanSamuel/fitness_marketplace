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

  TextEditingController _video = new TextEditingController();
  TextEditingController _live = new TextEditingController();
  TextEditingController _one = new TextEditingController();

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
            Container(
              width: 200,
              child: TextField(
                controller: _video,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Video Price'
                ),
              ),
            ),
            Container(
              width: 200,
              child: TextField(
                controller: _live,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Live Stream Price'
                ),
              ),
            ),
            Container(
              width: 200,
              child: TextField(
                controller: _one,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'One on One Price'
                ),
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
                    'videoPrice': toInt(_video.text),
                    'livePrice': toInt(_live.text),
                    'oneOnOnePrice': toInt(_one.text),
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
