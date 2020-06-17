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

  TextEditingController _video = new TextEditingController();
  TextEditingController _live = new TextEditingController();
  TextEditingController _one = new TextEditingController();

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
            Container(
              width: 200,
              child: TextField(
                controller: _video,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Video Price'
  ***REMOVED***,
***REMOVED***,
***REMOVED***
            Container(
              width: 200,
              child: TextField(
                controller: _live,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Live Stream Price'
  ***REMOVED***,
***REMOVED***,
***REMOVED***
            Container(
              width: 200,
              child: TextField(
                controller: _one,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'One on One Price'
  ***REMOVED***,
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
                    'videoPrice': toInt(_video.text),
                    'livePrice': toInt(_live.text),
                    'oneOnOnePrice': toInt(_one.text),
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
