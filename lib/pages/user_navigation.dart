import 'package:bottom_navy_bar/bottom_navy_bar.dart';
***REMOVED***
***REMOVED***
import 'package:fitnessmarketplace/models/Student.dart';
import 'package:fitnessmarketplace/pages/user_home_page.dart';
import 'package:fitnessmarketplace/pages/user_marketplace_page.dart';
import 'package:fitnessmarketplace/pages/user_profile_page.dart';
***REMOVED***

class UserNavigation extends StatefulWidget {
***REMOVED***
  _UserNavigationState createState() => _UserNavigationState();
***REMOVED***

class _UserNavigationState extends State<UserNavigation> {

  String name;
  int numClasses;
  int numPrivateSessions;
  int numVideos;
  bool doneLoading;

  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  var _pageOptions;

***REMOVED***
***REMOVED***
    doneLoading = false;
    _pageController = PageController();
    getData();
***REMOVED***
  ***REMOVED***

  getData() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userData = await Firestore.instance.collection('students').document(currentUser.uid).get();
    Student currentStudent =  Student.fromSnapshot(userData);
    name = currentStudent.firstName + ' ' + currentStudent.lastName;

    QuerySnapshot getClasses = await currentStudent.reference.collection('streams').getDocuments();
    numClasses = getClasses.documents.length;

    QuerySnapshot getPrivateSessions = await currentStudent.reference.collection('privateSessions').getDocuments();
    numPrivateSessions = getPrivateSessions.documents.length;

    QuerySnapshot getVideos = await currentStudent.reference.collection('videos').getDocuments();
    numVideos = getVideos.documents.length;

    _pageOptions = [
    UserHomePage(),
    MarketplaceScreen(),
    UserProfilePage(numClasses, numPrivateSessions, numVideos, name),
    ];

    setState(() {
      doneLoading = true;
    ***REMOVED***);
  ***REMOVED***

***REMOVED***
  void dispose() {
    _pageController.dispose();
    super.dispose();
  ***REMOVED***

***REMOVED***
***REMOVED***
    if (!doneLoading) {
  ***REMOVED***
        body: Center(
          child: CircularProgressIndicator(),
***REMOVED***
  ***REMOVED***
    ***REMOVED***
***REMOVED***
  ***REMOVED***
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
          ***REMOVED***
                  _currentIndex = index;
                ***REMOVED***);
              ***REMOVED***,
              children: _pageOptions,
***REMOVED***
***REMOVED***
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            showElevation: true, // use this to remove appBar's elevation
            itemCornerRadius: 20,
            curve: Curves.easeInBack,
            onItemSelected: (index) => setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            ***REMOVED***),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.red,
***REMOVED***,
              BottomNavyBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Marketplace'),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profile'),
                activeColor: Colors.blue,
***REMOVED***
***REMOVED***
          ));
    ***REMOVED***
  ***REMOVED***
***REMOVED***
