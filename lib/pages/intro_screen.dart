***REMOVED***
***REMOVED***
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'user_profile_page.dart';


class IntroScreen extends StatefulWidget {
***REMOVED***
  _IntroScreen createState() => _IntroScreen();
***REMOVED***

class _IntroScreen extends State<IntroScreen> {
***REMOVED***
***REMOVED***
    final onboardPages = [
      Container(color: Colors.pinkAccent, child: FirstScreen()),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[400],
                  Colors.blue[600]
                ])),
***REMOVED***
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
      ***REMOVED***
                    crossAxisAlignment: CrossAxisAlignment.stretch,
    ***REMOVED***
                      Container(
                        alignment: Alignment.centerRight,
                        child: skipButton(context),
        ***REMOVED***,
                      Padding(
                        padding: const EdgeInsets.all(60.0),
                        child: Container(
                          height: 340,
                          width: 10,
                          child: Image(
                              image: AssetImage('assets/images/Robot.png'),
                              fit: BoxFit.fill
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
                      Center(
                ***REMOVED***
                            padding: const EdgeInsets.all(16.0),
                  ***REMOVED***
              ***REMOVED***
          ***REMOVED***'Face off against our Ai',
                ***REMOVED***
                                        fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
                  ***REMOVED***,
          ***REMOVED***
                                    'and score more points that your opponent!',
                ***REMOVED***
                                        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***),
        ***REMOVED***,
                    ]))),
***REMOVED***
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple[300],
                  Colors.deepPurple[500]
                ])),
***REMOVED***
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
      ***REMOVED***
                    crossAxisAlignment: CrossAxisAlignment.stretch,
    ***REMOVED***
                      Container(
                        alignment: Alignment.centerRight,
                        child: skipButton(context),
        ***REMOVED***,
***REMOVED***
                        height: 20.0,
        ***REMOVED***,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 400,
                          width: 200,
                          child: Image(
                            image: AssetImage('assets/images/C-3po.webp'),
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
***REMOVED***
                        height: 50,
        ***REMOVED***,
                      Center(
                        child: Center(
                  ***REMOVED***
                            padding: const EdgeInsets.all(16.0),
                  ***REMOVED***
                  ***REMOVED***
          ***REMOVED***
                                    'Get points by determining',
                ***REMOVED***
                                        fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
                  ***REMOVED***,
          ***REMOVED***
                                    'if your opponent is real or not',
                ***REMOVED***
                                        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)
                  ***REMOVED***,
              ***REMOVED***
              ***REMOVED***,
            ***REMOVED***,
          ***REMOVED***,
        ***REMOVED***,
                    ]))),
***REMOVED***
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orange[300],
                  Colors.orange[500]
                ])),
***REMOVED***
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
      ***REMOVED***
                    crossAxisAlignment: CrossAxisAlignment.stretch,
    ***REMOVED***
                      Container(
                        alignment: Alignment.centerRight,
                        child: skipButton(context),
        ***REMOVED***,
***REMOVED***height: 100,),
                      Image.asset('assets/images/Twinkle.png',
                        height: 100,
                        width: 200,
        ***REMOVED***,
                      Image.asset('assets/images/Star.png',
                        height: 250,
                        width: 200,

        ***REMOVED***,
                      Image.asset('assets/images/Twinkle.png',
                        height: 100,
                        width: 200,

        ***REMOVED***,
                      Center(
                ***REMOVED***
                          padding: const EdgeInsets.all(16.0),
                ***REMOVED***children: <Widget>[
      ***REMOVED***
                                'Conquer the leaderboards',
            ***REMOVED***
                                    fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
              ***REMOVED***,
      ***REMOVED***
                                'and become the champion!',
            ***REMOVED***
                                    fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)
              ***REMOVED***,
                          ]),
          ***REMOVED***,
        ***REMOVED***,
                    ]))),
***REMOVED***
      Container(
        child: FinalScreen(),
      )
    ];
***REMOVED***
        body: LiquidSwipe(
          pages: onboardPages,
          fullTransitionValue: 400,
          enableLoop: true,
          enableSlideIcon: false,
          //positionSlideIcon: 0.8,
          waveType: WaveType.liquidReveal,
        ));
  ***REMOVED***

  Widget skipButton(BuildContext context) {
    return FlatButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinalScreen()),
    ***REMOVED***
      ***REMOVED***,
      child: Text(
        'Skip',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***

class FinalScreen extends StatelessWidget {
***REMOVED***
***REMOVED***
    return Container(
        color: Colors.orangeAccent,
***REMOVED***
            padding: const EdgeInsets.all(40.0),
  ***REMOVED***
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
***REMOVED***
                  AvatarGlow(
                    endRadius: 150,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.white24,
                    repeat: true,
                    repeatPauseDuration: Duration(seconds: 1),
                    startDelay: Duration(seconds: 1),
                    child: Material(
                        elevation: 25.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: FlutterLogo(
                            size: 100.0,
            ***REMOVED***,
                          radius: 100.0,
          ***REMOVED***),
    ***REMOVED***,
                  //SizedBox(height: 100,),
                  Center(
***REMOVED***
                        'Start your chatter today',
    ***REMOVED***
                            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
      ***REMOVED***,
    ***REMOVED***,
    ***REMOVED***
                    height: 30,
    ***REMOVED***,
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_forward_ios),
                    iconSize: 40,
                    onPressed:(){
***REMOVED***
                        context,
                        MaterialPageRoute(builder: (context) => (StudentProfilePage(3,4,5,"Samuel"))),
                  ***REMOVED***
                    ***REMOVED***,
    ***REMOVED***
                ])));
  ***REMOVED***
***REMOVED***

class FirstScreen extends StatefulWidget {
  final String title;

  FirstScreen({Key key, this.title***REMOVED***) : super(key: key);

***REMOVED***
  _FirstScreen createState() => _FirstScreen();
***REMOVED***

class _FirstScreen extends State<FirstScreen> {
  // Whether the green box should be visible
  bool _buttonVisible = true;
  bool _textVisible = false;

***REMOVED***
***REMOVED***
***REMOVED***
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green[300],
                  Colors.green[700]
                ])),
        child: Center(
          child: Stack(
            children: <Widget>[
              Center(
                // The green box must be a child of the AnimatedOpacity widget.
                child: Container(

                  child: Text(
                      'Welcome to Chatterbot',
  ***REMOVED***
                          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.italic)
    ***REMOVED***,
  ***REMOVED***,
***REMOVED***,
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***

