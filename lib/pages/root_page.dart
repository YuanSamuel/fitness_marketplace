***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/pages/register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
***REMOVED***

class RootPage extends StatefulWidget {
  RootPage({Key key***REMOVED***) : super(key: key);

***REMOVED***
  _RootPageState createState() => _RootPageState();
***REMOVED***

class _RootPageState extends State<RootPage> {

  FirebaseUser currentUser;
  bool doneLoading;
  bool isTrainer;

***REMOVED***
***REMOVED***
    doneLoading = false;
    isTrainer = false;
    getCurrentUser();
***REMOVED***
  ***REMOVED***

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    if (currentUser != null) {
      DocumentSnapshot userData = await Firestore.instance.collection('users').document(currentUser.uid).get();
      isTrainer = userData.data['isTrainer'];
    ***REMOVED***
    setState(() {
      doneLoading = true;
    ***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (!doneLoading) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED***
***REMOVED***
      if (currentUser == null) {
        return Register();
      ***REMOVED***
  ***REMOVED***
        if (isTrainer) {
          return TrainerNavigation();
        ***REMOVED***
    ***REMOVED***
          return UserNavigation();
        ***REMOVED***
      ***REMOVED***
    ***REMOVED***
  ***REMOVED***
***REMOVED***