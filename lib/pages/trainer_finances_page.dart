***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/models/PrivateSession.dart';
import 'package:fitnessmarketplace/models/RecordedVideo.dart';
***REMOVED***
***REMOVED***

class TrainerFinancesPage extends StatefulWidget {
  TrainerFinancesPage({Key key***REMOVED***) : super(key: key);

***REMOVED***
  _TrainerFinancesPageState createState() => _TrainerFinancesPageState();
***REMOVED***

class _TrainerFinancesPageState extends State<TrainerFinancesPage> {

  Trainer currentTrainer;
  List<RecordedVideo> trainerVideos;
  List<PrivateSession> trainerPrivateSessions;


***REMOVED***
***REMOVED***
    getUser();
***REMOVED***
  ***REMOVED***

  getUser() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance.collection('trainers').document(getUser.uid).get();
    currentTrainer = Trainer.fromSnapshot(userData);
  ***REMOVED***

***REMOVED***
***REMOVED***
    // TODO: implement build
    throw UnimplementedError();
  ***REMOVED***
***REMOVED***