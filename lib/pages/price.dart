***REMOVED***
***REMOVED***
import 'package:validators/sanitizers.dart';
import 'profile_picture.dart';
***REMOVED***
***REMOVED***

class PricePage extends StatefulWidget {
***REMOVED***
  _PricePageState createState() => _PricePageState();
***REMOVED***

class _PricePageState extends State<PricePage> {

  Trainer currentTrainer;

***REMOVED***
***REMOVED***
    getCurrentTrainer();
***REMOVED***
  ***REMOVED***

  void getCurrentTrainer() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot trainerData = await Firestore.instance.collection('trainers').document(getUser.uid).get();
    currentTrainer = Trainer.fromSnapshot(trainerData);
    setState(() {***REMOVED***);
  ***REMOVED***

  double _video = 0;
  double _live = 0;
  double _one = 0;

***REMOVED***
***REMOVED***
    if(currentTrainer==null){
      PricePage();
  ***REMOVED***
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
***REMOVED***
***REMOVED***
  ***REMOVED***
    ***REMOVED***
***REMOVED***
  ***REMOVED***
        body: Column(
          children: [
            Text(
              'Select Your Price',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
***REMOVED***,
***REMOVED***
            Text(
              'Video Price (per video): ${double.parse(_video.toStringAsFixed(2))***REMOVED***',
***REMOVED***
            Container(
              width: 300,
              child: Slider(
                value: _video,
                onChanged: (_input) {
            ***REMOVED***
                    _video = _input;
                  ***REMOVED***);
                ***REMOVED***,
                min: 0,
                max: 150,
***REMOVED***,
***REMOVED***
            Text(
              'Live Session Price (per hour): ${double.parse(_live.toStringAsFixed(2))***REMOVED***',
***REMOVED***
            Container(
              width: 300,
              child: Slider(
                value: _live,
                onChanged: (_input) {
            ***REMOVED***
                    _live = _input;
                  ***REMOVED***);
                ***REMOVED***,
                min: 0,
                max: 150,
***REMOVED***,
***REMOVED***
            Text(
              'One on One Session Price (per hour): ${double.parse(_one.toStringAsFixed(2))***REMOVED***',
***REMOVED***
            Container(
              width: 300,
              child: Slider(
                value: _one,
                onChanged: (_input) {
            ***REMOVED***
                    _one = _input;
                  ***REMOVED***);
                ***REMOVED***,
                min: 0,
                max: 150,
***REMOVED***,
***REMOVED***
            FlatButton(
              color: Colors.blue,
              child: Text('Continue'),
              onPressed: () async {
                final _user = await FirebaseAuth.instance.currentUser();
                String _uid = _user.uid;
                if(_video!=null&&_live!=null&&_one!=null) {
                  Firestore.instance.collection('trainers').document(_uid).setData({
                    'videoPrice': double.parse(_video.toStringAsFixed(2)),
                    'livePrice': double.parse(_live.toStringAsFixed(2)),
                    'oneOnOnePrice': double.parse(_one.toStringAsFixed(2)),
                  ***REMOVED***,merge: true);
                  if(currentTrainer.videoPrice!=0.0&&currentTrainer.livePrice!=0.0&&currentTrainer.oneOnOnePrice!=0.0){
                    Navigator.pop(context);
                  ***REMOVED***
              ***REMOVED***
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePic()),
                ***REMOVED***
                  ***REMOVED***
                ***REMOVED***
              ***REMOVED***,
***REMOVED***
          ],
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***
***REMOVED***
