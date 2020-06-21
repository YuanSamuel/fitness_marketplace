***REMOVED***
import 'package:fitnessmarketplace/pages/entry_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
***REMOVED***
import 'package:fitnessmarketplace/widgets/signup_widget.dart';
***REMOVED***
import 'package:fitnessmarketplace/pages/user_navigation.dart';
import 'package:fitnessmarketplace/pages/trainer_navigation.dart';

class LoginWidget extends StatefulWidget {
***REMOVED***
  _LoginWidgetState createState() => _LoginWidgetState();
***REMOVED***

class _LoginWidgetState extends State<LoginWidget> {

  int pageIndex = 0;
  TextEditingController emailInputController;
  TextEditingController passwordInputController;
  final GlobalKey<FormState> _loginFormKey = new GlobalKey();

***REMOVED***
***REMOVED***
    emailInputController = new TextEditingController();
    passwordInputController = new TextEditingController();
  ***REMOVED***

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3***REMOVED***\.[0-9]{1,3***REMOVED***\.[0-9]{1,3***REMOVED***\.[0-9]{1,3***REMOVED***\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,***REMOVED***))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    ***REMOVED*** else {
      return null;
    ***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
***REMOVED***
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          //height: double.infinity,
          //width: double.infinity,
***REMOVED***

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
                            ***REMOVED***);
                            ***REMOVED***,
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
                                  controller: passwordInputController,
                                  obscureText: true,
              ***REMOVED***
                                    color: Colors.black,
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

                      GestureDetector(
                        onTap: () async {
                          print("LOGIN ATTEMPTED");
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: emailInputController.text, password: passwordInputController.text)
                              .then((currentUser) async {
                            print(currentUser.user.uid);
                            DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(currentUser.user.uid).get();
                            print(snapshot.data);
                            if (snapshot.data['isTrainer']) {
        ***REMOVED***
      ***REMOVED***
      ***REMOVED***builder: (context) => TrainerNavigation()),
                          ***REMOVED***
                            ***REMOVED***
                        ***REMOVED***
        ***REMOVED***
      ***REMOVED***
      ***REMOVED***builder: (context) => UserNavigation()),
                          ***REMOVED***
                            ***REMOVED***
                          ***REMOVED***);
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
        ***REMOVED***,
                      FlatButton(
    ***REMOVED***'Register'),
    ***REMOVED***
    ***REMOVED***
  ***REMOVED***
  ***REMOVED***builder: (context) => (SignupWidget())),
                      ***REMOVED***
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
***REMOVED***
