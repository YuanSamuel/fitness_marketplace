<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/pages/request_private_session_page.dart';
=======
import 'package:fitnessmarketplace/animations/FadeAnimationDown.dart';
import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/pages/request_private_session_page.dart';
import 'package:fitnessmarketplace/pages/session_preview_page.dart';
>>>>>>> cc496090ba55f98356968332d4768446637a6e76
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
<<<<<<< HEAD
import 'package:validators/sanitizers.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
=======
import 'package:image_picker/image_picker.dart';
import 'package:validators/sanitizers.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';
>>>>>>> cc496090ba55f98356968332d4768446637a6e76

class TrainerWidget extends StatefulWidget {
  const TrainerWidget({Key key, this.trainer}) : super(key: key);

  final Trainer trainer;

  @override
  _TrainerWidgetState createState() => _TrainerWidgetState();
}

class _TrainerWidgetState extends State<TrainerWidget> {
<<<<<<< HEAD
  List<RecordedVideo> trainerVideos;
  List<DocumentSnapshot> trainerComments;
  int commentAmount;
  double rate;
=======
  List<DocumentSnapshot> trainerVideos;
>>>>>>> cc496090ba55f98356968332d4768446637a6e76

  @override
  void initState() {
    getRecordedVideos();
<<<<<<< HEAD
    getRate();
    super.initState();
  }

  getRate() async {
    QuerySnapshot rateQuery = await Firestore.instance.collection('comments').getDocuments();
    List<DocumentSnapshot> rateDoc = rateQuery.documents;
    int _amount = 0;
    int totalStar = 0;
    for(int i=0;i<rateDoc.length;i++) {
      if(rateDoc[i].data['uidTrainer']==widget.trainer.uid) {
        int newTotalStar = rateDoc[i].data['rating'];
        totalStar+=newTotalStar;
        _amount = _amount + 1;
      }
    }
    commentAmount = _amount;
    print(1.0*totalStar/commentAmount);
    rate = 1.0*totalStar/commentAmount;
    if(totalStar==0&&commentAmount==0) {
      rate = 0;
    }
    Firestore.instance.collection('trainers').document(widget.trainer.uid).setData({
      'rating': rate,
    },merge: true);
  }

  getRecordedVideos() async {
    trainerVideos = new List<RecordedVideo>();
=======
    super.initState();
  }

  getRecordedVideos() async {
>>>>>>> cc496090ba55f98356968332d4768446637a6e76
    QuerySnapshot queryVideos = await widget.trainer.reference
        .collection('recordedVideos')
        .getDocuments();
    List<DocumentSnapshot> videoData = queryVideos.documents;
<<<<<<< HEAD
    for (int i = 0; i < videoData.length; i++) {
      trainerVideos.add(RecordedVideo.fromSnapshot(videoData[i]));
    }
=======
    setState(() {
      trainerVideos = videoData;
    });
>>>>>>> cc496090ba55f98356968332d4768446637a6e76
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String trainerName =
        widget.trainer.firstName + ' ' + widget.trainer.lastName;
<<<<<<< HEAD

    TextEditingController _comment = new TextEditingController();

    int rating = 5;

=======
>>>>>>> cc496090ba55f98356968332d4768446637a6e76
    return Scaffold(
      backgroundColor: Colors.black,
      body: Hero(
        tag: trainerName,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.trainer.profileUrl),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [Colors.black, Colors.black.withOpacity(0.1)],
                        )),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FadeAnimationUp(
                                  1,
                                  Text(
                                    trainerName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  FadeAnimationUp(
                                      1.2,
                                      trainerVideos != null
                                          ? Text(
                                              trainerVideos.length.toString() + ' Videos',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            )
                                          : Text('loading')),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  FadeAnimationUp(
                                      1.3,
                                      Text(
                                        "10000 Live Sessions",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      )),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeAnimationUp(
                              1.5,
                              Row(
                                children: <Widget>[
                                  FutureBuilder(
                                    future: Firestore.instance.collection('trainers').document(widget.trainer.uid).get(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData) {
                                        return Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: snapshot.data['rating'],
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              snapshot.data['rating'].toStringAsFixed(2),
                                              style: TextStyle(color: Colors.white70),
                                            ),
                                          ],
                                        );
                                      }
                                      else {
                                        return Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: 0,
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(color: Colors.white70),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '($commentAmount)',
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 12),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          FadeAnimationUp(
                              1.6,
                              Text(
                                widget.trainer.description,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    height: 1.4),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          FadeAnimationUp(
                              1.6,
                              Text(
                                "Workouts Offered",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimationUp(
                              1.6,
                              Text(
                                widget.trainer.trainingTypes.toString().replaceAll('[', '').replaceAll(']', ''),
                                style: TextStyle(color: Colors.grey),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimationUp(
                              1.6,
                              Text(
                                "Preview Videos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimationUp(
                              1.8,
                               trainerVideos!= null
                                  ? Container(
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount: trainerVideos.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return FadeAnimationDown(
                                          1.2 + i / 10,
                                          makeVideo(
                                              image:
                                              trainerVideos[i].data["thumbUr"],
                                              vidReference: trainerVideos[i]),
                                        );
                          }),):CircularProgressIndicator()),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    )
                  ]),
                              Container(
                                height: 200,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    makeVideo(
                                        image:
                                            'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
                                    makeVideo(
                                        image:
                                            'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height-50,
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: TextField(
                                              controller: _comment,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'Add a Comment',
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.lightBlue
                                                  ),
                                                ),
                                              ),
                                            ),
                                            width: 300,
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: FlatButton(
                                              child: Icon(
                                                Icons.send,
                                                color: Colors.lightBlue,
                                              ),
                                              onPressed: () async {
                                                String currentUid;
                                                await FirebaseAuth.instance.currentUser().then((currentUser) => currentUid = currentUser.uid);
                                                Firestore.instance.collection('comments').document().setData({
                                                  'comment': _comment.text,
                                                  'rating': rating,
                                                  'uidStudent': currentUid,
                                                  'uidTrainer': widget.trainer.uid,
                                                });
                                                _comment.clear();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 10,
                                      ),
                                      RatingBar(
                                        initialRating: 5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (newRating) {
                                          rating = newRating.toInt();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                StreamBuilder(
                                  stream: Firestore.instance.collection('comments').snapshots(),
                                  builder: (context, snapshot) {
                                    List<DocumentSnapshot> commentDocs = snapshot.data.documents;
                                    if(snapshot.hasData) {
                                      return SizedBox(
                                        height: MediaQuery.of(context).size.height-150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: commentDocs.length,
                                          // ignore: missing_return
                                          itemBuilder: (BuildContext context, int i) {
                                            if(commentDocs[i].data['uidTrainer']==widget.trainer.uid){
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      FutureBuilder(
                                                        future: Firestore.instance.collection('students').document(commentDocs[i].data['uidStudent']).get(),
                                                        builder: (context, snapshot) {
                                                          if(snapshot.hasData) {

                                                            //First and Last Name of the User
                                                            return Text(
                                                              snapshot.data['firstName']+' '+snapshot.data['lastName'],
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.white,
                                                                fontSize: 25,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            );
                                                          }
                                                          else {
                                                            return SizedBox.shrink();
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      RatingBarIndicator(
                                                        rating: toDouble(commentDocs[i].data['rating'].toString()),
                                                        itemBuilder: (context, index) => Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 15,
                                                        direction: Axis.horizontal,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    commentDocs[i].data['comment'],
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 25,
                                                  ),
                                                ],
                                              );
                                            }
                                            },
                                          ),
                                        );
                                      }
                                      else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                  ),
                )
              ],
            ),
            Positioned.fill(
              bottom: 20,
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FadeAnimationUp(
                    2,
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red[700]),
                        child: Align(
                            child: Text(
                          "Schedule a Meeting",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestPrivateSessionPage(
                                  trainer: widget.trainer)),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget makeVideo({image, vidReference}) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SessionPreview(video: vidReference,isStream: false,trainer: widget.trainer,)),
        );
      },
      child: AspectRatio(
        aspectRatio: 1.5 / 1,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.9),
              Colors.black.withOpacity(.3)
            ])),
            child: Align(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
