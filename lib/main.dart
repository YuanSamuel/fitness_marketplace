import 'package:fitnessmarketplace/pages/trainer_home_screen.dart';
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';
import 'package:fitnessmarketplace/pages/user_marketplace_screen.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
***REMOVED***
import 'package:fitnessmarketplace/pages/register_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';

***REMOVED***
***REMOVED***


void main() {
  runApp(MyApp());
***REMOVED***

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
***REMOVED***
***REMOVED***
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
***REMOVED***
      debugShowCheckedModeBanner: false,
      home: UserNavigation(),
***REMOVED***
  ***REMOVED***
***REMOVED***

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title***REMOVED***) : super(key: key);

  final String title;

***REMOVED***
  _MyHomePageState createState() => _MyHomePageState();
***REMOVED***

class _MyHomePageState extends State<MyHomePage> {

***REMOVED***
***REMOVED***
***REMOVED***
      appBar: AppBar(
        title: Text(widget.title),
***REMOVED***
      body: Column(
        children: [
          RaisedButton(
            child: Text('User'),
***REMOVED***
          RaisedButton(
            child: Text('Trainer'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrainerHomePage()),
          ***REMOVED***
            ***REMOVED***,
***REMOVED***
        ],
      ));
  ***REMOVED***
***REMOVED***
