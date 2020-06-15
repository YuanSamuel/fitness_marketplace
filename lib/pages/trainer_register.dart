import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';
***REMOVED***
import 'package:select_dialog/select_dialog.dart';
***REMOVED***

import 'register_page.dart';

class TrainerRegister extends StatefulWidget {
***REMOVED***
  _TrainerRegisterState createState() => _TrainerRegisterState();
***REMOVED***

class _TrainerRegisterState extends State<TrainerRegister> {

  TypeOfExercise(String type){
    return Container(
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.blueAccent
***REMOVED***
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Text(type,
          style: TextStyle(
              color: Colors.white
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  TextEditingController _desc = new TextEditingController();
  List<String> _type = new List<String>();

***REMOVED***
***REMOVED***
***REMOVED***
      body: ListView(
        children: [
          Container(
  ***REMOVED***
  ***REMOVED***
  ***REMOVED***
                  height: 50,
  ***REMOVED***,
  ***REMOVED***
                  child: Container(
            ***REMOVED***
                      padding: EdgeInsets.all(5),
                      child: ListView(
            ***REMOVED***
                          TextField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: -20),
                                hintText: 'Tell us about yourself',
                                border: InputBorder.none
              ***REMOVED***,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
            ***REMOVED***,
        ***REMOVED***
                        scrollDirection: Axis.vertical,
        ***REMOVED***,
      ***REMOVED***,
        ***REMOVED***
                      border: Border.all(
                        width: 3,
                        color: Colors.blue,
        ***REMOVED***,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
      ***REMOVED***,
    ***REMOVED***,
                  width: MediaQuery.of(context).size.width-20,
                  height: 400,
  ***REMOVED***,
  ***REMOVED***
  ***REMOVED***
  ***REMOVED***,
                Container(
                  height: 15,
                  child: Row(
        ***REMOVED***
                      for(int i=0;i<_type.length;i++)
                        TypeOfExercise(_type[i]),
    ***REMOVED***
    ***REMOVED***,
  ***REMOVED***,
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => Scaffold(
                          body: SelectDialog(
                            itemsList: ['Running', 'Martial Arts', 'Cardio', 'Weight Lifting', 'Yoga'],
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
  ***REMOVED***,
                FlatButton(
                  color: Colors.blue,
                  child: Text('Continue'),
                  onPressed: () {
                    Firestore.instance.collection('trainers').document(userid).setData({
                      'type': _type,
                      'rating': 0,
                    ***REMOVED***,merge: true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePic()),
                ***REMOVED***
                  ***REMOVED***,
  ***REMOVED***
  ***REMOVED***
***REMOVED***
***REMOVED***
        ],
        scrollDirection: Axis.vertical,
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
