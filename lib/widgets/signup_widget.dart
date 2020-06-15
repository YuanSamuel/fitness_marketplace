***REMOVED***
import 'package:fitnessmarketplace/pages/entry_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
***REMOVED***
***REMOVED***

class SignupWidget extends StatefulWidget {
***REMOVED***
  _SignupWidgetState createState() => _SignupWidgetState();
***REMOVED***

class _SignupWidgetState extends State<SignupWidget> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController;
  TextEditingController emailInputController;
  TextEditingController passwordInputController;


***REMOVED***
***REMOVED***
***REMOVED***
    nameInputController = new TextEditingController();
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

  String passwordValidator(String value) {
    if (value.length < 8) {
      return 'Password length must be longer than 8 characters';
    ***REMOVED***
***REMOVED***
      return null;
    ***REMOVED***
  ***REMOVED***

***REMOVED***
***REMOVED***
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
                key: _signUpFormKey,
      ***REMOVED***
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
  ***REMOVED***
      ***REMOVED***
      ***REMOVED***
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios
            ***REMOVED***,
                          onPressed: (){setState(() {

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
                                controller: nameInputController,
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
                                validator: (input) {
                                  if (input.trim().length < 1) {
                                    return "Please input a valid name";
                                  ***REMOVED***
                              ***REMOVED***
                                    return null;
                                  ***REMOVED***
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
                                controller: emailInputController,

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
                      onTap: () {
                        print("HELLO");
                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailInputController.text, password: passwordInputController.text).then(
                                (currentUser) async {
                              Firestore.instance.collection('users').document(currentUser.user.uid).setData({
                                "name":nameInputController.text,
                                "email":emailInputController.text,
                                "uid":currentUser.user.uid,
                              ***REMOVED***);
                            ***REMOVED***);
  ***REMOVED***
***REMOVED***
***REMOVED***builder: (context) => TrainerHomePage()),
                    ***REMOVED***
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
      ***REMOVED***"Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          ***REMOVED***,
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
