import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:fitnessmarketplace/pages/request_private_session_page.dart';
***REMOVED***
***REMOVED***
***REMOVED***
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:validators/sanitizers.dart';
***REMOVED***

class TrainerWidget extends StatefulWidget {

  const TrainerWidget({Key key, this.trainer***REMOVED***) : super(key: key);

***REMOVED***

***REMOVED***
  _TrainerWidgetState createState() => _TrainerWidgetState();
***REMOVED***

class _TrainerWidgetState extends State<TrainerWidget> {
***REMOVED***
***REMOVED***
    String trainerName = widget.trainer.firstName + ' ' + widget.trainer.lastName;
***REMOVED***
            backgroundColor: Colors.black,
            body: Hero(
              tag: trainerName,
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
                                    image: NetworkImage(widget.trainer.profileUrl),
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
                                    FadeAnimationUp(1, Text(trainerName, style: TextStyle(
              ***REMOVED***
          ***REMOVED***
                                      fontSize: 40,
                      ***REMOVED***,)),
              ***REMOVED***height: 10,),
                      ***REMOVED***
                          ***REMOVED***
                                        FadeAnimationUp(1.2,
                      ***REMOVED***"Over 1000 Videos", style:
                                            TextStyle(
                    ***REMOVED***
                                                fontSize: 16
                              ***REMOVED***,)),
                  ***REMOVED***width: 50,),
                                        FadeAnimationUp(1.3,
                      ***REMOVED***"10000 Live Sessions", style:
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
                                      rating: widget.trainer.rating,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                        ***REMOVED***,
                                      itemCount: 5,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                      ***REMOVED***,
              ***REMOVED***width: 10,),
              ***REMOVED***widget.trainer.rating.toString(), style: TextStyle(color: Colors.white70),),
              ***REMOVED***width: 20,),
              ***REMOVED***'(2300)', style: TextStyle(color: Colors.white38, fontSize: 12),),
                  ***REMOVED***
                  ***REMOVED***),
          ***REMOVED***height: 5,),
                                FadeAnimationUp(1.6,
              ***REMOVED***widget.trainer.description,
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
              ***REMOVED***widget.trainer.trainingTypes.toString(), style: TextStyle(color: Colors.grey),)
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
                                      makeVideo(image: 'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
                                      makeVideo(image: 'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
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
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                  ***REMOVED***
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red[700]
                ***REMOVED***,
                              child: Align(child: Text("Schedule a Meeting", style: TextStyle(color: Colors.white, fontSize: 20),)),
              ***REMOVED***,
                            onTap: () {
        ***REMOVED***
      ***REMOVED***
      ***REMOVED***builder: (context) => RequestPrivateSessionPage(trainer: widget.trainer)),
                          ***REMOVED***
                            ***REMOVED***,
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