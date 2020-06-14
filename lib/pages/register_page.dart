import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';
import 'package:fitnessmarketplace/pages/user_home_page.dart';
***REMOVED***
import 'package:toggle_switch/toggle_switch.dart';
***REMOVED***
***REMOVED***

import 'login_page.dart';

String userid;
bool isTrainer = false;

class Register extends StatefulWidget {
***REMOVED***
  _RegisterState createState() => _RegisterState();
***REMOVED***

class _RegisterState extends State<Register> {

  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;

***REMOVED***
***REMOVED***
    _firstNameInputController = new TextEditingController();
    _lastNameInputController = new TextEditingController();
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      body: Column(
        children: [
          TextField(
            controller: _firstNameInputController,
            decoration: InputDecoration(
              hintText: 'First Name',
***REMOVED***
***REMOVED***
          TextField(
            controller: _lastNameInputController,
            decoration: InputDecoration(
              hintText: 'Last Name',
***REMOVED***
***REMOVED***
          TextField(
            controller: _emailInputController,
            decoration: InputDecoration(
                hintText: 'Email',
***REMOVED***
***REMOVED***
          TextField(
            controller: _passwordInputController,
            decoration: InputDecoration(
                hintText: 'Password',
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
              FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailInputController.text, password: _passwordInputController.text).then((currentUser) async {
                if (isTrainer) {
                  await Firestore.instance.collection('trainers').document(currentUser.user.uid).setData({
                    'firstName': _firstNameInputController.text,
                    'lastName': _lastNameInputController.text,
                    'uid': currentUser.user.uid,
                    'email': _emailInputController.text,
                    'rating': 0.0,
                  ***REMOVED***);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerRegister()),
              ***REMOVED***
                ***REMOVED***
            ***REMOVED***
                  Firestore.instance.collection('students').document(currentUser.user.uid).setData({
                    'firstName': _firstNameInputController.text,
                    'lastName': _lastNameInputController.text,
                    'uid': currentUser.user.uid,
                    'email': _emailInputController.text,
                  ***REMOVED***);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserHomePage()),
              ***REMOVED***
                ***REMOVED***
                userid = currentUser.user.uid;
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
