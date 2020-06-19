***REMOVED***
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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrainerWidget extends StatefulWidget {
  const TrainerWidget({Key key, this.trainer***REMOVED***) : super(key: key);

***REMOVED***

***REMOVED***
  _TrainerWidgetState createState() => _TrainerWidgetState();
***REMOVED***

class _TrainerWidgetState extends State<TrainerWidget> {
  List<RecordedVideo> trainerVideos;
  List<DocumentSnapshot> trainerComments;
  int commentAmount;
  double rate;

***REMOVED***
***REMOVED***
    getRecordedVideos();
    getRate();
***REMOVED***
  ***REMOVED***

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
      ***REMOVED***
    ***REMOVED***
    commentAmount = _amount;
    print(1.0*totalStar/commentAmount);
    rate = 1.0*totalStar/commentAmount;
    if(totalStar==0&&commentAmount==0) {
      rate = 0;
    ***REMOVED***
    Firestore.instance.collection('trainers').document(widget.trainer.uid).setData({
      'rating': rate,
    ***REMOVED***,merge: true);
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

    TextEditingController _comment = new TextEditingController();

    int rating = 5;

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
                                  FutureBuilder(
                                    future: Firestore.instance.collection('trainers').document(widget.trainer.uid).get(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData) {
                                        return Row(
                              ***REMOVED***
                                            RatingBarIndicator(
                                              rating: snapshot.data['rating'],
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
                                              snapshot.data['rating'].toStringAsFixed(2),
                          ***REMOVED***color: Colors.white70),
                              ***REMOVED***,
                          ***REMOVED***
                                    ***REMOVED***
                                      ***REMOVED***
                                  ***REMOVED***
                                        return Row(
                              ***REMOVED***
                                            RatingBarIndicator(
                                              rating: 0,
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
                                              '0',
                          ***REMOVED***color: Colors.white70),
                              ***REMOVED***,
                          ***REMOVED***
                                    ***REMOVED***
                                      ***REMOVED***
                                    ***REMOVED***,
                    ***REMOVED***,
            ***REMOVED***
                                    width: 20,
                    ***REMOVED***,
            ***REMOVED***
                                    '($commentAmount)',
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
                                widget.trainer.trainingTypes.toString().replaceAll('[', '').replaceAll(']', ''),
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
            ***REMOVED***,
    ***REMOVED***
                            height: MediaQuery.of(context).size.height-50,
                  ***REMOVED***
                  ***REMOVED***
                                Container(
                                  height: 100,
                        ***REMOVED***
                        ***REMOVED***
                        ***REMOVED***
                            ***REMOVED***
                    ***REMOVED***
                                            child: TextField(
                                              controller: _comment,
                          ***REMOVED***
                        ***REMOVED***
                                ***REMOVED***,
                                              decoration: InputDecoration(
                                                hintText: 'Add a Comment',
                                                enabledBorder: UnderlineInputBorder(
                              ***REMOVED*** BorderSide(
                                                      color: Colors.lightBlue
                                    ***REMOVED***,
                                  ***REMOVED***,
                                ***REMOVED***,
                              ***REMOVED***,
                                            width: 300,
                            ***REMOVED***,
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: FlatButton(
                                              child: Icon(
                                                Icons.send,
                                                color: Colors.lightBlue,
                                ***REMOVED***,
                                              onPressed: () async {
                                                String currentUid;
                                                await FirebaseAuth.instance.currentUser().then((currentUser) => currentUid = currentUser.uid);
                                                Firestore.instance.collection('comments').document().setData({
                                                  'comment': _comment.text,
                                                  'rating': rating,
                                                  'uidStudent': currentUid,
                                                  'uidTrainer': widget.trainer.uid,
                                                ***REMOVED***);
                                                _comment.clear();
                                              ***REMOVED***,
                              ***REMOVED***,
                            ***REMOVED***,
                        ***REMOVED***
                        ***REMOVED***,
                                      Container(
                        ***REMOVED***
                        ***REMOVED***,
                                      RatingBar(
                                        initialRating: 5,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                          ***REMOVED***,
                                        onRatingUpdate: (newRating) {
                                          rating = newRating.toInt();
                                        ***REMOVED***,
                        ***REMOVED***,
                    ***REMOVED***
                    ***REMOVED***,
                  ***REMOVED***,
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
                                    ***REMOVED***
                                    ***REMOVED***
                                    ***REMOVED***
                                        ***REMOVED***
                                                      FutureBuilder(
                                                        future: Firestore.instance.collection('students').document(commentDocs[i].data['uidStudent']).get(),
                                                        builder: (context, snapshot) {
                                                          if(snapshot.hasData) {

                                                            //First and Last Name of the User
                                                            return Text(
                                                              snapshot.data['firstName']+' '+snapshot.data['lastName'],
                                          ***REMOVED***
                                                                fontWeight: FontWeight.w500,
                                        ***REMOVED***
                                        ***REMOVED***
                                                ***REMOVED***,
                                                              textAlign: TextAlign.left,
                                                        ***REMOVED***
                                                          ***REMOVED***
                                                      ***REMOVED***
                                                            return SizedBox.shrink();
                                                          ***REMOVED***
                                                        ***REMOVED***,
                                        ***REMOVED***,
                                ***REMOVED***
                                                        width: 10,
                                        ***REMOVED***,
                                                      RatingBarIndicator(
                                                        rating: toDouble(commentDocs[i].data['rating'].toString()),
                                                        itemBuilder: (context, index) => Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                          ***REMOVED***,
                                                        itemCount: 5,
                                                        itemSize: 15,
                                                        direction: Axis.horizontal,
                                        ***REMOVED***,
                                    ***REMOVED***
                                    ***REMOVED***,
                            ***REMOVED***
                                                    height: 5,
                                    ***REMOVED***,
                            ***REMOVED***
                                                    commentDocs[i].data['comment'],
                                ***REMOVED***
                                                        color: Colors.white
                                      ***REMOVED***,
                                    ***REMOVED***,
                                                  Container(
                                                    height: 25,
                                    ***REMOVED***,
                                ***REMOVED***
                                          ***REMOVED***
                                            ***REMOVED***
                                            ***REMOVED***,
                            ***REMOVED***,
                                    ***REMOVED***
                                      ***REMOVED***
                                  ***REMOVED***
                                        return SizedBox.shrink();
                                      ***REMOVED***
                                    ***REMOVED***,
                    ***REMOVED***,
                ***REMOVED***
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
        ***REMOVED***
                    ]
    ***REMOVED***,
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
