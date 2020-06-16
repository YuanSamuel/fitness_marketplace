import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
***REMOVED***
***REMOVED***
***REMOVED***
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:validators/sanitizers.dart';

class Trainer extends StatefulWidget {
  final String uid;
  final int videoCount;
  final int sessions;
  final String video;
  final String video2;

  const Trainer({Key key, this.uid, this.videoCount, this.sessions, this.video, this.video2***REMOVED***) : super(key: key);

***REMOVED***
  _TrainerState createState() => _TrainerState();
***REMOVED***

class _TrainerState extends State<Trainer> {
***REMOVED***
***REMOVED***
    return StreamBuilder(
      stream: Firestore.instance.collection('trainers').document(widget.uid).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Container(
            width: 50,
            height: 50,
      ***REMOVED***
        ***REMOVED***
    ***REMOVED***
      ***REMOVED***
            backgroundColor: Colors.black,
            body: Hero(
              tag: '${snapshot.data['firstName']***REMOVED*** ${snapshot.data['lastName']***REMOVED***',
              child: Stack(
    ***REMOVED***
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 400,
                        backgroundColor: Colors.black,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                ***REMOVED***
                  ***REMOVED***
                                    image: NetworkImage(snapshot.data['profileUrl'].toString()),
                                    fit: BoxFit.cover
                  ***REMOVED***
              ***REMOVED***,
                            child: Container(
                  ***REMOVED***
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors:[
                                      Colors.black,
                                      Colors.black.withOpacity(0.1)
                    ***REMOVED***
                    ***REMOVED***
                ***REMOVED***,
                      ***REMOVED***
                      ***REMOVED***
                      ***REMOVED***
                      ***REMOVED***
                                  mainAxisAlignment: MainAxisAlignment.end,
                      ***REMOVED***
                                    FadeAnimationUp(1, Text('${snapshot.data['firstName']***REMOVED*** ${snapshot.data['lastName']***REMOVED***', style: TextStyle(
              ***REMOVED***
          ***REMOVED***
                                      fontSize: 40,
                      ***REMOVED***,)),
              ***REMOVED***height: 10,),
                      ***REMOVED***
                          ***REMOVED***
                                        FadeAnimationUp(1.2,
                      ***REMOVED***"Over "+widget.videoCount.toString()+" Videos", style:
                                            TextStyle(
                    ***REMOVED***
                                                fontSize: 16
                              ***REMOVED***,)),
                  ***REMOVED***width: 50,),
                                        FadeAnimationUp(1.3,
                      ***REMOVED***widget.sessions.toString()+"+ Live Sessions", style:
                                            TextStyle(
                    ***REMOVED***
                                                fontSize: 16
                              ***REMOVED***,)
                          ***REMOVED***,
                  ***REMOVED***height: 30,)
                      ***REMOVED***
                      ***REMOVED***
                  ***REMOVED***
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                  ***REMOVED***
                  ***REMOVED***
                  ***REMOVED***
                  ***REMOVED***
                                FadeAnimationUp(1.5, Row(
                  ***REMOVED***
                                    RatingBarIndicator(
                                      rating: toDouble(snapshot.data['rating'].toString()),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                        ***REMOVED***,
                                      itemCount: 5,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                      ***REMOVED***,
              ***REMOVED***width: 10,),
              ***REMOVED***snapshot.data['rating'].toString(), style: TextStyle(color: Colors.white70),),
              ***REMOVED***width: 20,),
              ***REMOVED***'(2300)', style: TextStyle(color: Colors.white38, fontSize: 12),),
                  ***REMOVED***
                  ***REMOVED***),
          ***REMOVED***height: 5,),
                                FadeAnimationUp(1.6,
              ***REMOVED***snapshot.data['desc'],
                  ***REMOVED***
              ***REMOVED***
                                          fontSize: 14,
                                          height: 1.4
                        ***REMOVED***,)),
          ***REMOVED***height: 40,),
                                FadeAnimationUp(1.6,
              ***REMOVED***"Workouts Offered", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                  ***REMOVED***,
          ***REMOVED***height: 10,),
                                FadeAnimationUp(1.6,
              ***REMOVED***snapshot.data['trainingTypes'].toString().substring(1, snapshot.data['trainingTypes'].toString().length), style: TextStyle(color: Colors.grey),)
                  ***REMOVED***,
          ***REMOVED***height: 30,),
                                FadeAnimationUp(1.6,
              ***REMOVED***"Preview Videos", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                  ***REMOVED***,
          ***REMOVED***height: 20,),
                                FadeAnimationUp(1.8, Container(
                                  height: 200,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                        ***REMOVED***
                                      makeVideo(image: widget.video),
                                      makeVideo(image: widget.video2),
                    ***REMOVED***
                    ***REMOVED***,
                  ***REMOVED***),
          ***REMOVED***height: 80,)
              ***REMOVED***
              ***REMOVED***,
            ***REMOVED***
                        ]),
        ***REMOVED***
    ***REMOVED***
    ***REMOVED***,
                  Positioned.fill(
                    bottom: 20,
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FadeAnimationUp(2,
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            height: 50,
                ***REMOVED***
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.red[700]
              ***REMOVED***,
                            child: Align(child: Text("Schedule a Meeting", style: TextStyle(color: Colors.white, fontSize: 20),)),
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***
***REMOVED***
***REMOVED***,
***REMOVED***
      ***REMOVED***
        ***REMOVED***
      ***REMOVED***,
***REMOVED***
  ***REMOVED***

  Widget makeVideo({image***REMOVED***) {
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
***REMOVED***
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.3)
                  ]
***REMOVED***
***REMOVED***
          child: Align(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 70,),
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***