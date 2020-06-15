import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
***REMOVED***
***REMOVED***

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

  const Trainer({Key key, this.name, this.image, this.category, this.languages, this.videoCount, this.sessions, this.video, this.video2, this.description***REMOVED***) : super(key: key);

***REMOVED***
  _TrainerState createState() => _TrainerState();
***REMOVED***

class _TrainerState extends State<Trainer> {
***REMOVED***
***REMOVED***
***REMOVED***
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
          ***REMOVED***
            ***REMOVED***
                              image: NetworkImage(widget.image),
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
                              FadeAnimationUp(1, Text(widget.name, style: TextStyle(
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
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                ***REMOVED***,
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                ***REMOVED***,
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                ***REMOVED***,
                              Container(
                                margin: EdgeInsets.only(right: 3),
                                child: Icon(Icons.star, color: Colors.yellow, size: 15,),
                ***REMOVED***,
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(Icons.star, color: Colors.grey, size: 15,),
                ***REMOVED***,
        ***REMOVED***'4.0', style: TextStyle(color: Colors.white70),),
        ***REMOVED***width: 20,),
        ***REMOVED***'(2300)', style: TextStyle(color: Colors.white38, fontSize: 12),),
            ***REMOVED***
            ***REMOVED***),
    ***REMOVED***height: 5,),
                          FadeAnimationUp(1.6,
        ***REMOVED***widget.description,
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
        ***REMOVED***widget.category, style: TextStyle(color: Colors.grey),)
            ***REMOVED***,
    ***REMOVED***height: 20,),
                          FadeAnimationUp(1.6,
        ***REMOVED***"Languages", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
            ***REMOVED***,
    ***REMOVED***height: 10,),
                          FadeAnimationUp(1.6,
        ***REMOVED***widget.languages, style: TextStyle(color: Colors.grey),)
            ***REMOVED***,
    ***REMOVED***height: 20,),
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
***REMOVED***
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
            )
          ],
***REMOVED***
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