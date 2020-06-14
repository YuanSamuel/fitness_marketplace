import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';
***REMOVED***
import 'package:toggle_switch/toggle_switch.dart';
***REMOVED***
***REMOVED***

import 'login.dart';

String userid;
bool isTrainer = false;

class Register extends StatefulWidget {
***REMOVED***
  _RegisterState createState() => _RegisterState();
***REMOVED***

class _RegisterState extends State<Register> {

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

***REMOVED***
***REMOVED***
    _name = new TextEditingController();
    _email = new TextEditingController();
    _password = new TextEditingController();
***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      body: Column(
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(
              hintText: 'Full Name'
***REMOVED***
***REMOVED***
          TextField(
            controller: _email,
            decoration: InputDecoration(
                hintText: 'Email'
***REMOVED***
***REMOVED***
          TextField(
            controller: _password,
            decoration: InputDecoration(
                hintText: 'Password'
***REMOVED***
***REMOVED***
          ToggleSwitch(
            minWidth: 90.0,
            cornerRadius: 20,
            activeBgColor: Colors.green,
            activeTextColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveTextColor: Colors.white,
            labels: ['Student', 'Trainer'],
            activeColors: [Colors.blue, Colors.green],
            onToggle: (index) {
              if(index==0){
                isTrainer = false;
              ***REMOVED***
          ***REMOVED***
                isTrainer = true;
              ***REMOVED***
              print('Trainer is '+isTrainer.toString());
            ***REMOVED***
***REMOVED***
          FlatButton(
            color: Colors.blue,
            child: Text('Register'),
            onPressed: () {
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text).then((currentUser) {
                if(isTrainer){
                  Firestore.instance.collection('trainers').document(currentUser.user.uid).setData({
                    'name': _name.text,
                    'uid': currentUser.user.uid,
                    'email': _email.text,
                  ***REMOVED***);
                ***REMOVED***
            ***REMOVED***
                  Firestore.instance.collection('users').document(currentUser.user.uid).setData({
                    'name': _name.text,
                    'uid': currentUser.user.uid,
                    'email': _email.text,
                  ***REMOVED***);
                ***REMOVED***
                userid = currentUser.user.uid;
                if(isTrainer==true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerRegister()),
              ***REMOVED***
                ***REMOVED***
            ***REMOVED***
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePic()),
              ***REMOVED***
                ***REMOVED***
              ***REMOVED***);
            ***REMOVED***,
***REMOVED***
          FlatButton(
            color: Colors.blue,
            child: Text('Login'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (Login())),
          ***REMOVED***
            ***REMOVED***,
***REMOVED***
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
