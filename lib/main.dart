import 'package:fitnessmarketplace/pages/agora_test_index_page.dart';
***REMOVED***
import 'pages/profile_page.dart';
import 'pages/add_new_screen.dart';

void main() {
  runApp(MyApp());
***REMOVED***

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
***REMOVED***
***REMOVED***
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
***REMOVED***
      home: AddNewRecording(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    ***REMOVED***);
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      appBar: AppBar(
        title: Text(widget.title),
***REMOVED***
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
***REMOVED***
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
***REMOVED***
          ],
***REMOVED***
***REMOVED***
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
***REMOVED*** // This trailing comma makes auto-formatting nicer for build methods.
***REMOVED***
  ***REMOVED***
***REMOVED***
