import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.black54]
                    )
                  ),
                  height: 400,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Adding a sizebox in place of the profile pick cause i dont know how to add one. Sounds like a you problem
                      SizedBox(height: 50),
                      Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // CUSTOMERS
                          Column(children: [
                            Text(
                              "$customers",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Text(
                              "Students",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ]),
                          // RATINGS
                          Column(children: [
                            Row(children: [
                              Text(
                                "$rating",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ]),
                            Text(
                              "Rating",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ]),
                          // YEARS
                          Column(children: [
                            Text(
                              "$years",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Text(
                              "Years",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ])
                        ],
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
                Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text("Place as many of these as you want"),
                            trailing: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text("Or you can make a class for these"),
                            trailing: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text("Its up to you"),
                            trailing: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}


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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Student Profile"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            )),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.black, Colors.black87]
                      )
                  ),
                  height: 400,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Adding a sizebox in place of the profile pick cause i dont know how to add one. Sounds like a you problem
                      SizedBox(height: 50),
                      Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // CUSTOMERS
                          Column(children: [
                            Text(
                              "$sessions",
                              style:
                              TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Text(
                              "Sessions",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ]),
                          // RATINGS
                          Column(children: [
                            Row(children: [
                              Text(
                                "$rating",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ]),
                            Text(
                              "Rating",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ]),
                          // YEARS
                          Column(children: [
                            Text(
                              "$years",
                              style:
                              TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            Text(
                              "Years",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ])
                        ],
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
                Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text("Place as many of these as you want"),
                            trailing: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text("Or you can make a class for these"),
                            trailing: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.star),
                            title: Text("Its up to you"),
                            trailing: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
