***REMOVED***
import 'package:fitnessmarketplace/pages/entry_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
***REMOVED***
import 'package:fitnessmarketplace/widgets/login_widget.dart';
***REMOVED***
import 'package:toggle_switch/toggle_switch.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';

class SignupWidget extends StatefulWidget {
***REMOVED***
  _SignupWidgetState createState() => _SignupWidgetState();
***REMOVED***

class _SignupWidgetState extends State<SignupWidget> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;
  bool _isTrainer;

***REMOVED***
***REMOVED***
    _isTrainer = false;
    _firstNameInputController = new TextEditingController();
    _lastNameInputController = new TextEditingController();
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
***REMOVED***
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
                                  controller: _firstNameInputController,
                                  keyboardType: TextInputType.emailAddress,
              ***REMOVED***
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                    ***REMOVED***,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                      ***REMOVED***,
                                    hintText: 'First Name',
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                ***REMOVED***
            ***REMOVED***
        ***REMOVED***height: 20.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: StyleConstants.loginBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: _lastNameInputController,
                                  keyboardType: TextInputType.emailAddress,
              ***REMOVED***
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                    ***REMOVED***,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                      ***REMOVED***,
                                    hintText: 'Last Name',
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
    ***REMOVED***height: 40.0,),
                          Column(
                ***REMOVED***
            ***REMOVED***
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: StyleConstants.loginBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: _emailInputController,

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
    ***REMOVED***height: 20.0),
                          Column(
                ***REMOVED***
            ***REMOVED***

                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: StyleConstants.loginBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: _passwordInputController,
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
                            height: 20,
            ***REMOVED***,
                          ToggleSwitch(
                              minWidth: 170.0,
                              cornerRadius: 20,
                              activeBgColor: Colors.green,
                              activeTextColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveTextColor: Colors.white,
                              labels: ['Student', 'Trainer'],
                              activeColors: [Colors.blue, Colors.green],
                              onToggle: (index) {
                                if (index == 0) {
                                  _isTrainer = false;
                                ***REMOVED*** else {
                                  _isTrainer = true;
                                ***REMOVED***
                                print('Trainer is ' + _isTrainer.toString());
                              ***REMOVED***
            ***REMOVED***,
        ***REMOVED***
        ***REMOVED***,

                      //SizedBox(height: MediaQuery.of(context).size.height / 5,),
***REMOVED***height: 40.0,),

                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: _emailInputController.text,
                              password: _passwordInputController.text)
                              .then((currentUser) async {
                            if (_isTrainer) {
                              await Firestore.instance
                                  .collection('users')
                                  .document(currentUser.user.uid)
                                  .setData({'isTrainer': true***REMOVED***);
                              await Firestore.instance
                                  .collection('trainers')
                                  .document(currentUser.user.uid)
                                  .setData({
                                'firstName': _firstNameInputController.text,
                                'lastName': _lastNameInputController.text,
                                'uid': currentUser.user.uid,
                                'email': _emailInputController.text,
                                'description': '',
                                'trainingTypes': new List<String>(),
                                'rating': 0.0,
                                'videoPrice': 0.0,
                                'livePrice': 0.0,
                                'oneOnOnePrice': 0.0
                              ***REMOVED***);
        ***REMOVED***
      ***REMOVED***
      ***REMOVED***builder: (context) => TrainerRegister()),
                          ***REMOVED***
                            ***REMOVED*** else {
                              await Firestore.instance
                                  .collection('users')
                                  .document(currentUser.user.uid)
                                  .setData({'isTrainer': false***REMOVED***);
                              await Firestore.instance
                                  .collection('students')
                                  .document(currentUser.user.uid)
                                  .setData({
                                'firstName': _firstNameInputController.text,
                                'lastName': _lastNameInputController.text,
                                'uid': currentUser.user.uid,
                                'email': _emailInputController.text,
                              ***REMOVED***);
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
                      FlatButton(
    ***REMOVED***'Login'),
    ***REMOVED***
    ***REMOVED***
  ***REMOVED***
  ***REMOVED***builder: (context) => (LoginWidget())),
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
