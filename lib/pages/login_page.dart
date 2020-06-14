import 'package:fitnessmarketplace/pages/register_page.dart';
import 'package:fitnessmarketplace/pages/user_home_page.dart';
***REMOVED***
***REMOVED***
***REMOVED***
import 'register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';

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
                  .then((currentUser) async {
                    print(currentUser.user.uid);
                    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(currentUser.user.uid).get();
                    print(snapshot.data);
                    if (snapshot.data['isTrainer']) {
***REMOVED***
                        context,
                        MaterialPageRoute(builder: (context) => TrainerHomePage()),
                  ***REMOVED***
                    ***REMOVED***
                ***REMOVED***
***REMOVED***
                        context,
                        MaterialPageRoute(builder: (context) => UserHomePage()),
                  ***REMOVED***
                    ***REMOVED***
              ***REMOVED***);
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
