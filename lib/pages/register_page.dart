import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/pages/user_home_page.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';
***REMOVED***
import 'package:toggle_switch/toggle_switch.dart';
***REMOVED***
***REMOVED***

import 'login_page.dart';

class Register extends StatefulWidget {
***REMOVED***
  _RegisterState createState() => _RegisterState();
***REMOVED***

class _RegisterState extends State<Register> {
  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;
  bool _isTrainer;

***REMOVED***
***REMOVED***
    _isTrainer = false;
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
                if (index == 0) {
                  _isTrainer = false;
                ***REMOVED*** else {
                  _isTrainer = true;
                ***REMOVED***
                print('Trainer is ' + _isTrainer.toString());
              ***REMOVED***),
          FlatButton(
            color: Colors.blue,
            child: Text('Register'),
            onPressed: () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailInputController.text,
                      password: _passwordInputController.text)
                  .then((currentUser) async {
                if (_isTrainer) {
                  await Firestore.instance
                      .collection('users')
                      .document(currentUser.user.uid)
                      .setData({'isTrainer': true***REMOVED***);
                  await Firestore.instance
                      .collection('trainers')
                      .document(currentUser.user.uid)
                      .setData({
                    'firstName': _firstNameInputController.text,
                    'lastName': _lastNameInputController.text,
                    'uid': currentUser.user.uid,
                    'email': _emailInputController.text,
                    'trainingTypes': new List<String>(),
                    'rating': 0.0,
                  ***REMOVED***);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TrainerRegister()),
              ***REMOVED***
                ***REMOVED*** else {
                  await Firestore.instance
                      .collection('users')
                      .document(currentUser.user.uid)
                      .setData({'isTrainer': false***REMOVED***);
                  await Firestore.instance
                      .collection('students')
                      .document(currentUser.user.uid)
                      .setData({
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
