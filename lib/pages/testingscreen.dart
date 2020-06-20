import 'package:fitnessmarketplace/widgets/curretnexericse_widget.dart';
import 'package:fitnessmarketplace/widgets/setexercise_widget.dart';
import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SetExercise(),
        ],
      ),
    );
  }
}
