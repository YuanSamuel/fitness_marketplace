import 'package:fitnessmarketplace/animations/FadeAnimationUp.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
import 'package:fitnessmarketplace/pages/request_private_session_page.dart';
***REMOVED***
***REMOVED***
***REMOVED***
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  List<RecordedVideo> trainerVideos;

***REMOVED***
***REMOVED***
    getRecordedVideos();
***REMOVED***
  ***REMOVED***

  getRecordedVideos() async {
    trainerVideos = new List<RecordedVideo>();
    QuerySnapshot queryVideos = await widget.trainer.reference
        .collection('recordedVideos')
        .getDocuments();
    List<DocumentSnapshot> videoData = queryVideos.documents;
    for (int i = 0; i < videoData.length; i++) {
      trainerVideos.add(RecordedVideo.fromSnapshot(videoData[i]));
    ***REMOVED***
    setState(() {***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
    String trainerName =
        widget.trainer.firstName + ' ' + widget.trainer.lastName;
***REMOVED***
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
          ***REMOVED***
            ***REMOVED***
                              image: NetworkImage(widget.trainer.profileUrl),
                              fit: BoxFit.cover)),
                      child: Container(
            ***REMOVED***
                            gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [Colors.black, Colors.black.withOpacity(0.1)],
          ***REMOVED***),
                ***REMOVED***
                ***REMOVED***
                ***REMOVED***
                ***REMOVED***
                            mainAxisAlignment: MainAxisAlignment.end,
                ***REMOVED***
                              FadeAnimationUp(
                                  1,
            ***REMOVED***
                                    trainerName,
                ***REMOVED***
              ***REMOVED***
          ***REMOVED***
                                      fontSize: 40,
                      ***REMOVED***,
                    ***REMOVED***),
        ***REMOVED***
                ***REMOVED***
                ***REMOVED***,
                ***REMOVED***
                    ***REMOVED***
                                  FadeAnimationUp(
                                      1.2,
                                      trainerVideos != null
                                          ? Text(
                                              trainerVideos.length.toString() + ' Videos',
                          ***REMOVED***
                      ***REMOVED***
                                                  fontSize: 16),
                              ***REMOVED***
                                          : Text('loading')),
            ***REMOVED***
                                    width: 50,
                    ***REMOVED***,
                                  FadeAnimationUp(
                                      1.3,
                ***REMOVED***
                                        "10000 Live Sessions",
                    ***REMOVED***
                ***REMOVED*** fontSize: 16),
                        ***REMOVED***),
            ***REMOVED***
                                    height: 30,
                    ***REMOVED***
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
                          FadeAnimationUp(
                              1.5,
                ***REMOVED***
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
            ***REMOVED***
                                    width: 10,
                    ***REMOVED***,
            ***REMOVED***
                                    widget.trainer.rating.toString(),
                ***REMOVED***color: Colors.white70),
                    ***REMOVED***,
            ***REMOVED***
                                    width: 20,
                    ***REMOVED***,
            ***REMOVED***
                                    '(2300)',
                ***REMOVED***
                                        color: Colors.white38, fontSize: 12),
                    ***REMOVED***,
                ***REMOVED***
                ***REMOVED***),
    ***REMOVED***
                            height: 5,
            ***REMOVED***,
                          FadeAnimationUp(
                              1.6,
        ***REMOVED***
                                widget.trainer.description,
            ***REMOVED***
        ***REMOVED***
                                    fontSize: 14,
                                    height: 1.4),
                ***REMOVED***),
    ***REMOVED***
                            height: 40,
            ***REMOVED***,
                          FadeAnimationUp(
                              1.6,
        ***REMOVED***
                                "Workouts Offered",
            ***REMOVED***
            ***REMOVED***
                                    fontSize: 18,
            ***REMOVED***
                ***REMOVED***),
    ***REMOVED***
            ***REMOVED***
            ***REMOVED***,
                          FadeAnimationUp(
                              1.6,
        ***REMOVED***
                                widget.trainer.trainingTypes.toString(),
            ***REMOVED***color: Colors.grey),
                ***REMOVED***),
    ***REMOVED***
                            height: 30,
            ***REMOVED***,
                          FadeAnimationUp(
                              1.6,
        ***REMOVED***
                                "Preview Videos",
            ***REMOVED***
            ***REMOVED***
                                    fontSize: 18,
            ***REMOVED***
                ***REMOVED***),
    ***REMOVED***
                            height: 20,
            ***REMOVED***,
                          FadeAnimationUp(
                              1.8,
                              Container(
                                height: 200,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                      ***REMOVED***
                                    makeVideo(
                                        image:
                                            'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
                                    makeVideo(
                                        image:
                                            'https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg'),
                  ***REMOVED***
                  ***REMOVED***,
                ***REMOVED***),
    ***REMOVED***
                            height: 80,
            ***REMOVED***
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
                  child: FadeAnimationUp(
                    2,
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        height: 50,
            ***REMOVED***
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red[700]),
                        child: Align(
        ***REMOVED***
                          "Schedule a Meeting",
      ***REMOVED***color: Colors.white, fontSize: 20),
          ***REMOVED***),
        ***REMOVED***,
                      onTap: () {
  ***REMOVED***
***REMOVED***
***REMOVED***
                              builder: (context) => RequestPrivateSessionPage(
                                  trainer: widget.trainer)),
                    ***REMOVED***
                      ***REMOVED***,
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
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
