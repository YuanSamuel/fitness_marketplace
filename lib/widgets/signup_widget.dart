import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessmarketplace/pages/entry_page.dart';
import 'package:fitnessmarketplace/pages/trainer_home_page.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessmarketplace/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:fitnessmarketplace/pages/user_navigation.dart';
import 'package:fitnessmarketplace/pages/trainer_register.dart';

class SignupWidget extends StatefulWidget {
  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;
  bool _isTrainer;

  @override
  void initState() {
    _isTrainer = false;
    _firstNameInputController = new TextEditingController();
    _lastNameInputController = new TextEditingController();
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return 'Password length must be longer than 8 characters';
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          //height: double.infinity,
          //width: double.infinity,
            decoration: BoxDecoration(

            ),
            //padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios
                            ),
                            onPressed: (){setState(() {

                            });},
                          ),
                          SizedBox(width: 90.0,),
                          Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(

                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 40.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: StyleConstants.loginBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: _firstNameInputController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    hintText: 'First Name',
                                    hintStyle: StyleConstants.loginHintTextStyle,
                                  ),
                                  validator: (input) {
                                    if (input.trim().length < 1) {
                                      return "Please input a valid name";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: StyleConstants.loginBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: _lastNameInputController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Last Name',
                                    hintStyle: StyleConstants.loginHintTextStyle,
                                  ),
                                  validator: (input) {
                                    if (input.trim().length < 1) {
                                      return "Please input a valid name";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: StyleConstants.loginBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: _emailInputController,

                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Enter your Email',
                                    hintStyle: StyleConstants.loginHintTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: StyleConstants.loginBoxDecorationStyle,
                                height: 60.0,
                                child: TextFormField(
                                  controller: _passwordInputController,
                                  obscureText: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Enter your Password',
                                    hintStyle: StyleConstants.loginHintTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                                } else {
                                  _isTrainer = true;
                                }
                                print('Trainer is ' + _isTrainer.toString());
                              }
                          ),
                        ],
                      ),

                      //SizedBox(height: MediaQuery.of(context).size.height / 5,),
                      SizedBox(height: 40.0,),

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
                                  .setData({'isTrainer': true});
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
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TrainerRegister()),
                              );
                            } else {
                              await Firestore.instance
                                  .collection('users')
                                  .document(currentUser.user.uid)
                                  .setData({'isTrainer': false});
                              await Firestore.instance
                                  .collection('students')
                                  .document(currentUser.user.uid)
                                  .setData({
                                'firstName': _firstNameInputController.text,
                                'lastName': _lastNameInputController.text,
                                'uid': currentUser.user.uid,
                                'email': _emailInputController.text,
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserNavigation()),
                              );
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3.0,
                              ),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white
                          ),
                          child: Center(
                            child: Text("Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                      FlatButton(
                        child: Text('Login'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => (LoginWidget())),
                          );
                        },
                      ),
                    ],
                  ),
                )
            )
        ),
      ),
    );
  }
}
