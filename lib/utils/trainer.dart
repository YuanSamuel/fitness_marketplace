import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:validators/sanitizers.dart';

class Trainer extends StatefulWidget {
  final String uid;
  final int videoCount;
  final int sessions;
  final String video;
  final String video2;

  const Trainer({Key key, this.uid, this.videoCount, this.sessions, this.video, this.video2}) : super(key: key);

  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('trainers').document(widget.uid).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Container(
            width: 50,
            height: 50,
          );
        }
        else{
          return Scaffold(
            backgroundColor: Colors.black,
            body: Hero(
              tag: '${snapshot.data['firstName']} ${snapshot.data['lastName']}',
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
                                    image: NetworkImage(snapshot.data['profileUrl'].toString()),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors:[
                                      Colors.black,
                                      Colors.black.withOpacity(0.1)
                                    ],
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FadeAnimationUp(1, Text('${snapshot.data['firstName']} ${snapshot.data['lastName']}', style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),)),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        FadeAnimationUp(1.2,
                                            Text("Over "+widget.videoCount.toString()+" Videos", style:
                                            TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16
                                            ),)),
                                        SizedBox(width: 50,),
                                        FadeAnimationUp(1.3,
                                            Text(widget.sessions.toString()+"+ Live Sessions", style:
                                            TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16
                                            ),)
                                        ),
                                        SizedBox(height: 30,)
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
                                FadeAnimationUp(1.5, Row(
                                  children: <Widget>[
                                    RatingBarIndicator(
                                      rating: toDouble(snapshot.data['rating'].toString()),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(snapshot.data['rating'].toString(), style: TextStyle(color: Colors.white70),),
                                    SizedBox(width: 20,),
                                    Text('(2300)', style: TextStyle(color: Colors.white38, fontSize: 12),),
                                  ],
                                )),
                                SizedBox(height: 5,),
                                FadeAnimationUp(1.6,
                                    Text(snapshot.data['desc'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          height: 1.4
                                      ),)),
                                SizedBox(height: 40,),
                                FadeAnimationUp(1.6,
                                    Text("Workouts Offered", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                                ),
                                SizedBox(height: 10,),
                                FadeAnimationUp(1.6,
                                    Text(snapshot.data['trainingTypes'].toString().substring(1, snapshot.data['trainingTypes'].toString().length), style: TextStyle(color: Colors.grey),)
                                ),
                                SizedBox(height: 30,),
                                FadeAnimationUp(1.6,
                                    Text("Preview Videos", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                                ),
                                SizedBox(height: 20,),
                                FadeAnimationUp(1.8, Container(
                                  height: 200,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      makeVideo(image: widget.video),
                                      makeVideo(image: widget.video2),
                                    ],
                                  ),
                                )),
                                SizedBox(height: 80,)
                              ],
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                  Positioned.fill(
                    bottom: 20,
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FadeAnimationUp(2,
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red[700]
                            ),
                            child: Align(child: Text("Schedule a Meeting", style: TextStyle(color: Colors.white, fontSize: 20),)),
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
      },
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5/1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.3)
                  ]
              )
          ),
          child: Align(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 70,),
          ),
        ),
      ),
    );
  }
}