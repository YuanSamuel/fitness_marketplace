***REMOVED***
***REMOVED***

//The profile system is set up so when you open the page you call either Driver or

class UserProfilePage extends StatelessWidget {
  int customers;
  int rating;
  int years;
  String name;

  UserProfilePage(int cust, int rat, int year, String n) {
    customers = cust;
    rating = rat;
    years = year;
    name = n;
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
        body: ListView(
          children: [
            Column(
  ***REMOVED***
                Container(
      ***REMOVED***
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.black54]
      ***REMOVED***
    ***REMOVED***,
                  height: 400,
                  width: 400,
        ***REMOVED***
                    mainAxisAlignment: MainAxisAlignment.end,
        ***REMOVED***
                      //Adding a sizebox in place of the profile pick cause i dont know how to add one. Sounds like a you problem
***REMOVED***height: 50),
***REMOVED***
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
                              "$customers",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
              ***REMOVED***,
      ***REMOVED***
                              "Students",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
              ***REMOVED***,
                          ]),
                          // RATINGS
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
              ***REMOVED***,
                          ]),
                          // YEARS
                          Column(children: [
      ***REMOVED***
                              "$years",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
              ***REMOVED***,
      ***REMOVED***
                              "Years",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                            title: Text("Place as many of these as you want"),
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
                            title: Text("Or you can make a class for these"),
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
      ***REMOVED***,
                    FlatButton(
  ***REMOVED***'Log Out'),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.popAndPushNamed(context, '/register');
                      ***REMOVED***,
      ***REMOVED***
  ***REMOVED***
  ***REMOVED***,
  ***REMOVED***
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
        body: ListView(
          children: [
            Column(
  ***REMOVED***
                Container(
      ***REMOVED***
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.black, Colors.black87]
        ***REMOVED***
    ***REMOVED***,
                  height: 400,
                  width: 400,
        ***REMOVED***
                    mainAxisAlignment: MainAxisAlignment.end,
        ***REMOVED***
                      //Adding a sizebox in place of the profile pick cause i dont know how to add one. Sounds like a you problem
***REMOVED***height: 50),
***REMOVED***
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
                              "$sessions",
                              style:
                              TextStyle(color: Colors.white, fontSize: 24),
              ***REMOVED***,
      ***REMOVED***
                              "Sessions",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
              ***REMOVED***,
                          ]),
                          // RATINGS
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
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
              ***REMOVED***,
                          ]),
                          // YEARS
                          Column(children: [
      ***REMOVED***
                              "$years",
                              style:
                              TextStyle(color: Colors.white, fontSize: 24),
              ***REMOVED***,
      ***REMOVED***
                              "Years",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
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
                            title: Text("Place as many of these as you want"),
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
                            title: Text("Or you can make a class for these"),
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
***REMOVED***
          ],
        ));
  ***REMOVED***
***REMOVED***
