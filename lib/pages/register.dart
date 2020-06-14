import 'package:fitnessmarketplace/pages/trainer_register.dart';
***REMOVED***
import 'package:toggle_switch/toggle_switch.dart';
***REMOVED***
***REMOVED***

import 'login.dart';

String userid;

class Register extends StatefulWidget {
***REMOVED***
  _RegisterState createState() => _RegisterState();
***REMOVED***

class _RegisterState extends State<Register> {

  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _isTrainer = false;

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
                _isTrainer = false;
              ***REMOVED***
          ***REMOVED***
                _isTrainer = true;
              ***REMOVED***
              print('Trainer is '+_isTrainer.toString());
            ***REMOVED***
***REMOVED***
          FlatButton(
            color: Colors.blue,
            child: Text('Register'),
            onPressed: () {
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text).then((currentUser) {
                Firestore.instance.collection('users').document(currentUser.user.uid).setData({
                  'name': _name.text,
                  'uid': currentUser.user.uid,
                  'email': _email.text,
                  'istrainer': _isTrainer,
                ***REMOVED***);
                userid = currentUser.user.uid;
                if(_isTrainer==true){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerRegister()),
              ***REMOVED***
                ***REMOVED***
            ***REMOVED***
                  //To Home Page
                ***REMOVED***
              ***REMOVED***);
              print('Registered '+_email.text+' as User ID '+userid);
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
