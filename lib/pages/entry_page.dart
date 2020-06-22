import 'package:fitnessmarketplace/utils/fade_animation.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
import 'package:fitnessmarketplace/widgets/login_widget.dart';
import 'package:fitnessmarketplace/widgets/signup_widget.dart';
***REMOVED***

class EntryPage extends StatefulWidget {
***REMOVED***
  _EntryPageState createState() => _EntryPageState();
***REMOVED***

class _EntryPageState extends State<EntryPage> {
  int status = 0;
  PageController controller = PageController(initialPage: 0,);
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  static PageController _controller;

***REMOVED***
***REMOVED***
    _controller = PageController(
      initialPage: 0,
***REMOVED***
***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bckground.png"),
            fit: BoxFit.cover,
***REMOVED***
***REMOVED***
        child: Column(
          children: <Widget>[
            SizedBox(height: 75.0,),
            Text('FITNESSSSSS', style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            Text('FIT | NESS | FIT', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w400),),
            SizedBox(height: 75.0,),
            Expanded(
              child: Container(
    ***REMOVED***
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0) )
  ***REMOVED***,

                //child: status == 0 ? _buildEntryPage() : status == 1 ? new LoginWidget() : _buildSignupPage(),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
      ***REMOVED***
                    _buildEntryPage(),
                    SingleChildScrollView(
            ***REMOVED***
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
            ***REMOVED***
    ***REMOVED***height: 20.0,),
            ***REMOVED***
            ***REMOVED***
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios
                  ***REMOVED***,
                                onPressed: (){setState(() {
                                  _controller.jumpToPage(0);
                                ***REMOVED***);
                                ***REMOVED***,
                ***REMOVED***,
        ***REMOVED***width: 105.0,),
        ***REMOVED***
                                'Login',
            ***REMOVED***
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
      ***REMOVED***
                  ***REMOVED***,
                ***REMOVED***,
            ***REMOVED***
            ***REMOVED***,
                          LoginWidget(),
        ***REMOVED***
        ***REMOVED***,
      ***REMOVED***,
                    SingleChildScrollView(
            ***REMOVED***
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
            ***REMOVED***
    ***REMOVED***height: 20.0,),
            ***REMOVED***
            ***REMOVED***
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios
                  ***REMOVED***,
                                onPressed: (){setState(() {
                                  _controller.jumpToPage(0);
                                ***REMOVED***);
                                ***REMOVED***,
                ***REMOVED***,
        ***REMOVED***width: 100.0,),
        ***REMOVED***
                                'Signup',
            ***REMOVED***
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
      ***REMOVED***
                  ***REMOVED***,
                ***REMOVED***,
            ***REMOVED***
            ***REMOVED***,
                          SignupWidget(),
        ***REMOVED***
        ***REMOVED***,
      ***REMOVED***,
  ***REMOVED***
  ***REMOVED***,
***REMOVED***,
***REMOVED***
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  Widget _buildEntryPage(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
***REMOVED***
                  Container(
                    child: Center(
                        //child: Image.asset('assets/img/gardening.png')
  ***REMOVED***'Text Description of the app 1'),
      ***REMOVED***,
    ***REMOVED***,
                  Container(
                    child: Center(
  ***REMOVED***'Text Description of the app 2'),
      ***REMOVED***,
    ***REMOVED***,
                  Container(
                    child: Center(
  ***REMOVED***'Text Description of the app 3'),
      ***REMOVED***,
    ***REMOVED***,
***REMOVED***
***REMOVED***,
***REMOVED***

            SizedBox(height: 30.0,),

            FadeAnimation(1.6,
                GestureDetector(
                  onTap: (){
              ***REMOVED***
                      status = 1;
                    ***REMOVED***);
                    _controller.jumpToPage(1);
                  ***REMOVED***,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 50),
        ***REMOVED***
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black
      ***REMOVED***,
                    child: Center(
  ***REMOVED***"Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ***REMOVED***,
    ***REMOVED***,
  ***REMOVED***),
            SizedBox(height: 20.0,),
            FadeAnimation(1.8, GestureDetector(
              onTap: (){
          ***REMOVED***
                  _controller.jumpToPage(2);
                ***REMOVED***);
              ***REMOVED***,
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
    ***REMOVED***
                    border: Border.all(
                      color: Colors.black,
                      width: 3.0,
      ***REMOVED***,
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white
  ***REMOVED***,
                child: Center(
                  child: Text("Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
  ***REMOVED***,
***REMOVED***,
            )),
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***

  _buildLoginPage(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(

***REMOVED***
          //padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
      ***REMOVED***
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
  ***REMOVED***
      ***REMOVED***
      ***REMOVED***
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios
            ***REMOVED***,
                          onPressed: (){setState(() {
                            status = 0;
                          ***REMOVED***);***REMOVED***,
          ***REMOVED***,
  ***REMOVED***width: 90.0,),
  ***REMOVED***
                          'Login',
      ***REMOVED***
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
***REMOVED***
            ***REMOVED***,
          ***REMOVED***,
      ***REMOVED***
      ***REMOVED***,
                    Column(

      ***REMOVED***
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
              ***REMOVED***
          ***REMOVED***
      ***REMOVED***height: 40.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: emailInputController,
                                keyboardType: TextInputType.emailAddress,
            ***REMOVED***
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                  ***REMOVED***,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                    ***REMOVED***,
                                  hintText: 'Enter your Email',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
  ***REMOVED***height: 20.0,),
                        Column(
              ***REMOVED***
          ***REMOVED***
      ***REMOVED***height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: pwdInputController,
                                obscureText: true,
            ***REMOVED***
          ***REMOVED***
                                  fontFamily: 'OpenSans',
                  ***REMOVED***,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                    ***REMOVED***,
                                  hintText: 'Enter your Password',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
      ***REMOVED***
      ***REMOVED***,

                    //SizedBox(height: MediaQuery.of(context).size.height / 5,),
      ***REMOVED***height: 40.0,),

                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
          ***REMOVED***
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black
        ***REMOVED***,
                      child: Center(
    ***REMOVED***"Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ***REMOVED***,
      ***REMOVED***,

  ***REMOVED***
  ***REMOVED***,
***REMOVED***
          )
***REMOVED***
***REMOVED***
  ***REMOVED***

  _buildSignupPage(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(

***REMOVED***
          //padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
      ***REMOVED***
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
  ***REMOVED***
      ***REMOVED***
      ***REMOVED***
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios
            ***REMOVED***,
                          onPressed: (){setState(() {
                            status = 0;
                          ***REMOVED***);***REMOVED***,
          ***REMOVED***,
  ***REMOVED***width: 90.0,),
  ***REMOVED***
                          'Signup',
      ***REMOVED***
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
***REMOVED***
            ***REMOVED***,
          ***REMOVED***,
      ***REMOVED***
      ***REMOVED***,
                    Column(

      ***REMOVED***
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
              ***REMOVED***
          ***REMOVED***
      ***REMOVED***height: 40.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: emailInputController,
                                keyboardType: TextInputType.emailAddress,
            ***REMOVED***
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                  ***REMOVED***,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                    ***REMOVED***,
                                  hintText: 'Full Name',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
  ***REMOVED***height: 20.0,),
                        Column(
              ***REMOVED***
          ***REMOVED***
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: pwdInputController,
                                obscureText: true,
            ***REMOVED***
          ***REMOVED***
                                  fontFamily: 'OpenSans',
                  ***REMOVED***,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                    ***REMOVED***,
                                  hintText: 'Enter your Email',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
  ***REMOVED***height: 20.0),
                        Column(
              ***REMOVED***
          ***REMOVED***

                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: pwdInputController,
                                obscureText: true,
            ***REMOVED***
          ***REMOVED***
                                  fontFamily: 'OpenSans',
                  ***REMOVED***,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                    ***REMOVED***,
                                  hintText: 'Enter your Password',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                  ***REMOVED***,
                ***REMOVED***,
              ***REMOVED***,
          ***REMOVED***
          ***REMOVED***,
      ***REMOVED***
      ***REMOVED***,

                    //SizedBox(height: MediaQuery.of(context).size.height / 5,),
      ***REMOVED***height: 40.0,),

                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
          ***REMOVED***
                          border: Border.all(
                            color: Colors.black,
                            width: 3.0,
            ***REMOVED***,
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white
        ***REMOVED***,
                      child: Center(
    ***REMOVED***"Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        ***REMOVED***,
      ***REMOVED***,

  ***REMOVED***
  ***REMOVED***,
***REMOVED***
          )
***REMOVED***
***REMOVED***
  ***REMOVED***


***REMOVED***
