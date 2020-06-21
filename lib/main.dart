import 'package:fitnessmarketplace/pages/register.dart';
import 'package:fitnessmarketplace/pages/root_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
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
      routes: <String, WidgetBuilder> {
        '/register': (BuildContext context) => Register(),
      ***REMOVED***,
      home: RootPage(),
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
