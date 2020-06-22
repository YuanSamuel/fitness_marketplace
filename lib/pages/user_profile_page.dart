import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                      colors: [Colors.black, Colors.black54])),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //SizedBox(height: 50),
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
                          numClasses.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        Text(
                          "Classes Registered",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ]),
                      // RATINGS
                      Column(children: [
                        Row(children: [
                          Text(
                            numPrivateSessions.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ]),
                        Text(
                          'Private Sessions',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ]),
                      // YEARS
                      Column(children: [
                        Text(
                          numVideos.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        Text(
                          "Videos Purchased",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ])
                    ],
                  ),
                  SizedBox(height: 140)
                ],
              ),
            ),
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
               body: StreamBuilder(
                  stream: Firestore.instance.collection('Student Profile Page').snapshots(),
                        builder: (context,snapshot){
                    if(!snapshot.hasData) return const Text('Loading...');
               return ListView(
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
          );
         }
       )

    );
  }
}
