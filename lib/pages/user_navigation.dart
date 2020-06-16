import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fitnessmarketplace/pages/user_home_page.dart';
import 'package:fitnessmarketplace/pages/user_marketplace_page.dart';
import 'package:fitnessmarketplace/pages/user_profile_page.dart';
***REMOVED***
import 'login_page.dart';

class UserNavigation extends StatefulWidget {
***REMOVED***
  _UserNavigationState createState() => _UserNavigationState();
***REMOVED***

class _UserNavigationState extends State<UserNavigation> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  var _pageOptions = [
    UserHomePage(userid),
    MarketplaceScreen(),
    UserProfilePage(1, 2, 3, 'SamuelY'),
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
  ***REMOVED***
***REMOVED***
