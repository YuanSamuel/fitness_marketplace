***REMOVED***
***REMOVED***
***REMOVED***

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
        ],
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
