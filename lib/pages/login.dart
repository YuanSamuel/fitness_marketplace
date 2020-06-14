import 'package:fitnessmarketplace/pages/register.dart';
***REMOVED***
***REMOVED***
***REMOVED***
import 'register.dart';

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
          FlatButton(
            color: Colors.blue,
            child: Text('Login'),
            onPressed: () {
              print("Attempt Login");
                FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text).then(
                        (currentUser) {
                      Firestore.instance.collection('users').document(currentUser.user.uid).get().then(
                              (value) {
                            userid = currentUser.user.uid;
                            //To Home Page
                          ***REMOVED***);
                    ***REMOVED***
            ***REMOVED***
                print('Logged in '+_email.text+' as User ID '+userid);
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
