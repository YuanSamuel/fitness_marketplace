import 'package:fitnessmarketplace/pages/register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
***REMOVED***
***REMOVED***
***REMOVED***

String userid;

class Login extends StatefulWidget {
***REMOVED***
  _LoginState createState() => _LoginState();
***REMOVED***

class _LoginState extends State<Login> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

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
                    userid = currentUser.user.uid;
                    if (snapshot.data['isTrainer']) {
***REMOVED***
                        context,
                        MaterialPageRoute(builder: (context) => TrainerNavigation()),
                  ***REMOVED***
                    ***REMOVED***
                ***REMOVED***
***REMOVED***
                        context,
                        MaterialPageRoute(builder: (context) => UserNavigation()),
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
