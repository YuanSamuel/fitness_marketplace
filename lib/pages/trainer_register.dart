***REMOVED***
import 'package:fitnessmarketplace/pages/profile_picture.dart';
***REMOVED***
import 'package:select_dialog/select_dialog.dart';
***REMOVED***

class TrainerRegister extends StatefulWidget {
***REMOVED***
  _TrainerRegisterState createState() => _TrainerRegisterState();
***REMOVED***

class _TrainerRegisterState extends State<TrainerRegister> {
  List<String> _type = new List<String>();
  FirebaseUser currentUser;

***REMOVED***
***REMOVED***
    getUser();
***REMOVED***
  ***REMOVED***

  getUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    setState(() {***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (currentUser == null) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED*** else {
  ***REMOVED***
        body: Container(
***REMOVED***
***REMOVED***
***REMOVED***
                width: MediaQuery.of(context).size.width,
                child: Text(_type.toString()),
***REMOVED***,
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => Scaffold(
                            body: SelectDialog(
                              itemsList: [
                                'Running',
                                'Martial Arts',
                                'Cardio',
                                'Weight Lifting',
                                'Yoga',
              ***REMOVED***
                              onChange: (String selected) {
                          ***REMOVED***
                                  bool hasSelected = false;
                                  for (int i = 0; i < _type.length; i++) {
                                    if (selected == _type[i]) {
                                      hasSelected = true;
                                    ***REMOVED***
                                  ***REMOVED***
                                  if (!hasSelected) {
                                    _type.add(selected);
                                  ***REMOVED***
                                ***REMOVED***);
                              ***REMOVED***,
              ***REMOVED***,
            ***REMOVED***);
                ***REMOVED***,
                child: Text('Select Type'),
***REMOVED***,
              FlatButton(
                color: Colors.blue,
                child: Text('Continue'),
                onPressed: () {
                  Firestore.instance
                      .collection('trainers')
                      .document(currentUser.uid)
                      .updateData({
                    'trainingTypes': _type,
                  ***REMOVED***);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePic()),
              ***REMOVED***
                ***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
    ***REMOVED***
  ***REMOVED***
***REMOVED***
