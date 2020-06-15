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
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.black12,
        border: Border.all(color: Colors.grey)
***REMOVED***
      child: FlatButton(
***REMOVED***
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Text(type,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black
***REMOVED***
***REMOVED***
***REMOVED***
        onPressed: () {
          _type.remove(type);
    ***REMOVED***
            TrainerRegister();
          ***REMOVED***);
        ***REMOVED***,
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
                            controller: _desc,
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
                  height: 30,
          ***REMOVED***
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
          ***REMOVED***
                        for(int i=0;i<_type.length;i++)
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: TypeOfExercise(_type[i]),
            ***REMOVED***,
      ***REMOVED***
                      scrollDirection: Axis.horizontal,
      ***REMOVED***,
    ***REMOVED***,
  ***REMOVED***,
                Container(
                  height: 5,
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
                      'desc': _desc,
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
