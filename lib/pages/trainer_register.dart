***REMOVED***
import 'package:select_dialog/select_dialog.dart';
***REMOVED***

import 'register.dart';

class TrainerRegister extends StatefulWidget {
***REMOVED***
  _TrainerRegisterState createState() => _TrainerRegisterState();
***REMOVED***

class _TrainerRegisterState extends State<TrainerRegister> {

  List<String> _type = new List<String>();

***REMOVED***
***REMOVED***
***REMOVED***
      body: Container(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(_type.toString()),
***REMOVED***
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Scaffold(
                    body: SelectDialog(
                      itemsList: ['Running', 'Martial Arts', 'Cardio', 'Lifting', 'Yoga'],
                      onChange: (String selected) {
                  ***REMOVED***
                          bool hasSelected = false;
                          for(int i=0;i<_type.length;i++){
                            if(selected==_type[i]){
                              hasSelected = true;
                            ***REMOVED***
                          ***REMOVED***
                          if(!hasSelected){
                            _type.add(selected);
                          ***REMOVED***
                        ***REMOVED***);
                      ***REMOVED***,
      ***REMOVED***,
    ***REMOVED***
            ***REMOVED***
              ***REMOVED***,
              child: Text('Select Type'),
***REMOVED***
            FlatButton(
              color: Colors.blue,
              child: Text('Continue'),
              onPressed: () {
                Firestore.instance.collection('users').document(userid).setData({
                  'type': _type,
                  'rating': 0,
                ***REMOVED***,merge: true);
                //To Home Page
              ***REMOVED***,
            )
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
