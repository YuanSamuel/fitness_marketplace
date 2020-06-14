import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/pages/trainer_profile_page.dart';
import 'package:flutter/material.dart';



class TrainerNavigation extends StatefulWidget {
  @override
  _TrainerNavigationState createState() => _TrainerNavigationState();
}

class _TrainerNavigationState extends State<TrainerNavigation> {

  int _currentIndex=0;
  PageController _pageController = PageController(
    initialPage: 0
  );
  var _pageOptions = [
    TrainerHomePage(),
    TrainerProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              TrainerHomePage(),
              TrainerProfile(),
            ],
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
                title: Text('Cool'),
                activeColor: Colors.purpleAccent
            ),
          ],
        )
    );
  }
}
