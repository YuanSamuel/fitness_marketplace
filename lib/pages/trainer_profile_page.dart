***REMOVED***
import 'package:fitnessmarketplace/pages/profile_picture.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';
***REMOVED***
***REMOVED***
import 'login_page.dart';

class TrainerProfile extends StatelessWidget {
***REMOVED***
***REMOVED***
***REMOVED***
      body: Column(
        children: [
          RaisedButton(
            child: Text('Sign Out'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popAndPushNamed(context, '/register');
            ***REMOVED***,
***REMOVED***
          RaisedButton(
            child: Text('Change Profile Picture'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (ProfilePic())),
          ***REMOVED***
            ***REMOVED***,
***REMOVED***
          RaisedButton(
            child: Text('Change Bio and Type'),
            onPressed:  () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (TrainerRegister(userid))),
          ***REMOVED***
            ***REMOVED***,
***REMOVED***
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
