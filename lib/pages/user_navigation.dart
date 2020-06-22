import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/models/Student.dart';
import 'package:fitnessmarketplace/pages/user_home_page.dart';
import 'package:fitnessmarketplace/pages/user_marketplace_page.dart';
import 'package:fitnessmarketplace/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

class UserNavigation extends StatefulWidget {
  @override
  _UserNavigationState createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  String name;
  int numClasses;
  int numPrivateSessions;
  int numVideos;
  bool doneLoading;

  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  var _pageOptions;

  @override
  void initState() {
    doneLoading = false;
    _pageController = PageController();
    getData();
    super.initState();
  }

  getData() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance
        .collection('students')
        .document(currentUser.uid)
        .get();
    Student currentStudent = Student.fromSnapshot(userData);
    name = currentStudent.firstName + ' ' + currentStudent.lastName;

    print(name);

    QuerySnapshot getClasses =
        await currentStudent.reference.collection('streams').getDocuments();
    numClasses = getClasses.documents.length;

    QuerySnapshot getPrivateSessions = await currentStudent.reference
        .collection('privateSessions')
        .getDocuments();
    numPrivateSessions = getPrivateSessions.documents.length;

    QuerySnapshot getVideos =
        await currentStudent.reference.collection('videos').getDocuments();
    numVideos = getVideos.documents.length;

    _pageOptions = [
      UserHomePage(),
      MarketplaceScreen(),
      UserProfilePage(numClasses, numPrivateSessions, numVideos, name),
    ];

    setState(() {
      doneLoading = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!doneLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _pageOptions,
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            showElevation: true, // use this to remove appBar's elevation
            itemCornerRadius: 20,
            curve: Curves.easeInBack,
            onItemSelected: (index) => setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Marketplace'),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profile'),
                activeColor: Colors.blue,
              )
            ],
          ));
    }
  }
}
