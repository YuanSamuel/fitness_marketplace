import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:fitnessmarketplace/pages/request_private_session_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:validators/sanitizers.dart';
import 'package:fitnessmarketplace/models/Trainer.dart';

class TrainerWidget extends StatefulWidget {

  const TrainerWidget({Key key, this.trainer}) : super(key: key);

  final Trainer trainer;

  @override
  _TrainerWidgetState createState() => _TrainerWidgetState();
}

class _TrainerWidgetState extends State<TrainerWidget> {
  @override
  Widget build(BuildContext context) {
    String trainerName = widget.trainer.firstName + ' ' + widget.trainer.lastName;
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
                                    FadeAnimationUp(1, Text(trainerName, style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),)),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        FadeAnimationUp(1.2,
                                            Text("Over 1000 Videos", style:
                                            TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16
                                            ),)),
                                        SizedBox(width: 50,),
                                        FadeAnimationUp(1.3,
                                            Text("10000 Live Sessions", style:
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
                                      rating: widget.trainer.rating,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(widget.trainer.rating.toString(), style: TextStyle(color: Colors.white70),),
                                    SizedBox(width: 20,),
                                    Text('(2300)', style: TextStyle(color: Colors.white38, fontSize: 12),),
                                  ],
                                )),
                                SizedBox(height: 5,),
                                FadeAnimationUp(1.6,
                                    Text('add this to the database',
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
                                    Text(widget.trainer.trainingTypes.toString(), style: TextStyle(color: Colors.grey),)
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
                                      makeVideo(image: 'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
                                      makeVideo(image: 'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
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
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red[700]
                              ),
                              child: Align(child: Text("Schedule a Meeting", style: TextStyle(color: Colors.white, fontSize: 20),)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RequestPrivateSessionPage(trainer: widget.trainer,)),
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