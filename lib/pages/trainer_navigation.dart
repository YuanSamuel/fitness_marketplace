import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/pages/trainer_profile_page.dart';
***REMOVED***



class TrainerNavigation extends StatefulWidget {
***REMOVED***
  _TrainerNavigationState createState() => _TrainerNavigationState();
***REMOVED***

class _TrainerNavigationState extends State<TrainerNavigation> {

  int _currentIndex=0;
  PageController _pageController = PageController(
    initialPage: 0
  );
  var _pageOptions = [
    TrainerHomePage(),
    TrainerProfile(),
  ];

***REMOVED***
***REMOVED***
***REMOVED***
    _pageController = PageController();
  ***REMOVED***

***REMOVED***
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
***REMOVED***
            BottomNavyBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor: Colors.black38
***REMOVED***
          ],
        )
***REMOVED***
  ***REMOVED***
***REMOVED***
