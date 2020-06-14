import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trainer extends StatefulWidget {
  final String name;
  final String image;
  final String description;
  final String category;
  final String languages;
  final int videoCount;
  final int sessions;
  final String video;
  final String video2;

  const Trainer({Key key, this.name, this.image, this.category, this.languages, this.videoCount, this.sessions, this.video, this.video2, this.description}) : super(key: key);

  @override
  _TrainerState createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Hero(
        tag: widget.name,
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
                              image: NetworkImage(widget.image),
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
                              FadeAnimationUp(1, Text(widget.name, style: TextStyle(
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
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(Icons.star, color: Colors.grey, size: 15,),
                              ),
                              Text('4.0', style: TextStyle(color: Colors.white70),),
                              SizedBox(width: 20,),
                              Text('(2300)', style: TextStyle(color: Colors.white38, fontSize: 12),),
                            ],
                          )),
                          SizedBox(height: 5,),
                          FadeAnimationUp(1.6,
                              Text(widget.description,
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
                              Text(widget.category, style: TextStyle(color: Colors.grey),)
                          ),
                          SizedBox(height: 20,),
                          FadeAnimationUp(1.6,
                              Text("Languages", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                          ),
                          SizedBox(height: 10,),
                          FadeAnimationUp(1.6,
                              Text(widget.languages, style: TextStyle(color: Colors.grey),)
                          ),
                          SizedBox(height: 20,),
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