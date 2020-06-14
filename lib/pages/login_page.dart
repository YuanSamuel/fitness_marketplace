
import 'package:fitnessmarketplace/pages/register_page.dart';
***REMOVED***
***REMOVED***
***REMOVED***
import 'register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';

class Login extends StatefulWidget {
***REMOVED***
  _LoginState createState() => _LoginState();
***REMOVED***

class _LoginState extends State<Login> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _isTrainer = true;

***REMOVED***
***REMOVED***
***REMOVED***
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(hintText: 'Email'),
***REMOVED***
          TextField(
            controller: _password,
            decoration: InputDecoration(hintText: 'Password'),
***REMOVED***
          FlatButton(
            color: Colors.blue,
            child: Text('Login'),
            onPressed: () async {
              print("Attempt Login");
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _email.text, password: _password.text)
                  .then((currentUser) {
                    if (_isTrainer) {
***REMOVED***
                        context,
                        MaterialPageRoute(builder: (context) => TrainerHomeScreen()),
                  ***REMOVED***
                    ***REMOVED***
              ***REMOVED***);
              print('Logged in ' + _email.text + ' as User ID ' + userid);
            ***REMOVED***,
***REMOVED***
          FlatButton(
            color: Colors.blue,
            child: Text('Register'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (Register())),
          ***REMOVED***
            ***REMOVED***,
***REMOVED***
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
