***REMOVED***
***REMOVED***
***REMOVED***

//The profile system is set up so when you open the page you call either Driver or

class UserProfilePage extends StatelessWidget {
  int numClasses;
  int numPrivateSessions;
  int numVideos;
  String name;

  UserProfilePage(int classes, int privateSessions, int videos, String n) {
    numClasses = classes;
    numPrivateSessions = privateSessions;
    numVideos = videos;
    name = n;
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
        body: ListView(
      children: [
        Column(
          children: [
            Container(
  ***REMOVED***
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.black54])),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
    ***REMOVED***
                mainAxisAlignment: MainAxisAlignment.end,
    ***REMOVED***
                  //SizedBox(height: 50),
                  Text(
                    name,
***REMOVED***color: Colors.white, fontSize: 26),
    ***REMOVED***,
    ***REMOVED***
                    height: 20,
    ***REMOVED***,
    ***REMOVED***
    ***REMOVED***
        ***REMOVED***
                      // CUSTOMERS
                      Column(children: [
  ***REMOVED***
                          numClasses.toString(),
      ***REMOVED***color: Colors.white, fontSize: 24),
          ***REMOVED***,
  ***REMOVED***
                          "Classes Registered",
      ***REMOVED***color: Colors.white, fontSize: 12),
          ***REMOVED***,
                      ]),
                      // RATINGS
                      Column(children: [
          ***REMOVED***children: [
    ***REMOVED***
                            numPrivateSessions.toString(),
        ***REMOVED***color: Colors.white, fontSize: 24),
            ***REMOVED***,
                        ]),
  ***REMOVED***
                          'Private Sessions',
      ***REMOVED***color: Colors.white, fontSize: 12),
          ***REMOVED***,
                      ]),
                      // YEARS
                      Column(children: [
  ***REMOVED***
                          numVideos.toString(),
      ***REMOVED***color: Colors.white, fontSize: 24),
          ***REMOVED***,
  ***REMOVED***
                          "Videos Purchased",
      ***REMOVED***color: Colors.white, fontSize: 12),
          ***REMOVED***,
                      ])
    ***REMOVED***
    ***REMOVED***,
    ***REMOVED***height: 140)
***REMOVED***
***REMOVED***,
***REMOVED***
          ],
***REMOVED***
      ],
    ));
  ***REMOVED***
***REMOVED***

//////Here is the page for students

class StudentProfilePage extends StatelessWidget {
  int sessions;
  int rating;
  int years;
  String name;

  StudentProfilePage(int sesh, int rat, int year, String n) {
    sessions = sesh;
    rating = rat;
    years = year;
    name = n;
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Student Profile"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {***REMOVED***,
            )),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Student Profile Page')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return ListView(
    ***REMOVED***
                  Column(
        ***REMOVED***
                      Container(
            ***REMOVED***
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.black, Colors.black87])),
                        height: 400,
                        width: 400,
              ***REMOVED***
                          mainAxisAlignment: MainAxisAlignment.end,
              ***REMOVED***
      ***REMOVED***height: 50),
      ***REMOVED***
                              name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
              ***REMOVED***,
      ***REMOVED***
                              height: 20,
              ***REMOVED***,
              ***REMOVED***
              ***REMOVED***
                  ***REMOVED***
                                Column(children: [
            ***REMOVED***
                                    "$sessions",
                ***REMOVED***
                ***REMOVED*** fontSize: 24),
                    ***REMOVED***,
            ***REMOVED***
                                    "Sessions",
                ***REMOVED***
                ***REMOVED*** fontSize: 16),
                    ***REMOVED***,
                                ]),
                                Column(children: [
                    ***REMOVED***children: [
              ***REMOVED***
                                      "$rating",
                  ***REMOVED***
                  ***REMOVED*** fontSize: 24),
                      ***REMOVED***,
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                      ***REMOVED***
                                  ]),
            ***REMOVED***
                                    "Rating",
                ***REMOVED***
                ***REMOVED*** fontSize: 16),
                    ***REMOVED***,
                                ]),
                                Column(children: [
            ***REMOVED***
                                    "$years",
                ***REMOVED***
                ***REMOVED*** fontSize: 24),
                    ***REMOVED***,
            ***REMOVED***
                                    "Years",
                ***REMOVED***
                ***REMOVED*** fontSize: 16),
                    ***REMOVED***,
                                ])
              ***REMOVED***
              ***REMOVED***,
      ***REMOVED***height: 20)
          ***REMOVED***
          ***REMOVED***,
        ***REMOVED***,
                      Column(
            ***REMOVED***
                          Card(
                  ***REMOVED***
                  ***REMOVED***
                                ListTile(
                                  leading: Icon(Icons.star),
                                  title: Text(
                                      "Place as many of these as you want"),
                                  trailing: Icon(Icons.edit),
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***,
            ***REMOVED***,
                          Card(
                  ***REMOVED***
                  ***REMOVED***
                                ListTile(
                                  leading: Icon(Icons.star),
                                  title:
                ***REMOVED***"Or you can make a class for these"),
                                  trailing: Icon(Icons.edit),
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***,
            ***REMOVED***,
                          Card(
                  ***REMOVED***
                  ***REMOVED***
                                ListTile(
                                  leading: Icon(Icons.star),
                                  title: Text("Its up to you"),
                                  trailing: Icon(Icons.edit),
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***,
            ***REMOVED***
        ***REMOVED***
        ***REMOVED***
    ***REMOVED***
    ***REMOVED***,
***REMOVED***
          ***REMOVED***
            ***REMOVED***));
  ***REMOVED***
***REMOVED***
