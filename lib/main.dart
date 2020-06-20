import 'package:fitnessmarketplace/pages/add_new_screen.dart';
import 'package:fitnessmarketplace/pages/root_page.dart';

import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/widgets/login_widget.dart';
import 'package:fitnessmarketplace/widgets/signup_widget.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/register': (BuildContext context) => SignupWidget(),
      },
      home: RootPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            RaisedButton(
              child: Text('User'),
            ),
            RaisedButton(
              child: Text('Trainer'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrainerHomePage()),
                );
              },
            ),
          ],
        ));
  }
}
