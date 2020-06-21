import 'package:fitnessmarketplace/utils/fade_animation.dart';
import 'package:fitnessmarketplace/utils/style_constants.dart';
import 'package:fitnessmarketplace/widgets/login_widget.dart';
import 'package:fitnessmarketplace/widgets/signup_widget.dart';
import 'package:flutter/material.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  int status = 0;
  PageController controller = PageController(initialPage: 0,);
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  static PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bckground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 75.0,),
            Text('FITNESSSSSS', style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            Text('FIT | NESS | FIT', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w400),),
            SizedBox(height: 75.0,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0) )
                ),

                //child: status == 0 ? _buildEntryPage() : status == 1 ? new LoginWidget() : _buildSignupPage(),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: [
                    _buildEntryPage(),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 20.0,),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios
                                ),
                                onPressed: (){setState(() {
                                  _controller.jumpToPage(0);
                                });
                                },
                              ),
                              SizedBox(width: 105.0,),
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          LoginWidget(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 20.0,),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios
                                ),
                                onPressed: (){setState(() {
                                  _controller.jumpToPage(0);
                                });
                                },
                              ),
                              SizedBox(width: 100.0,),
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
                          SignupWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                children: <Widget>[
                  Container(
                    child: Center(
                        //child: Image.asset('assets/img/gardening.png')
                      child: Text('Text Description of the app 1'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Text Description of the app 2'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Text Description of the app 3'),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.0,),

            FadeAnimation(1.6,
                GestureDetector(
                  onTap: (){
                    setState(() {
                      status = 1;
                    });
                    _controller.jumpToPage(1);
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black
                    ),
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                )),
            SizedBox(height: 20.0,),
            FadeAnimation(1.6, GestureDetector(
              onTap: (){
                setState(() {
                  _controller.jumpToPage(2);
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
            )),
          ],
        ),
      ),
    );
  }

  _buildLoginPage(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(

          ),
          //padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios
                          ),
                          onPressed: (){setState(() {
                            status = 0;
                          });},
                        ),
                        SizedBox(width: 90.0,),
                        Text(
                          'Login',
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
                                controller: emailInputController,
                                keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: pwdInputController,
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,
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
                      ],
                    ),

                    //SizedBox(height: MediaQuery.of(context).size.height / 5,),
                    SizedBox(height: 40.0,),

                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black
                      ),
                      child: Center(
                        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),

                  ],
                ),
              )
          )
      ),
    );
  }

  _buildSignupPage(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(

          ),
          //padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios
                          ),
                          onPressed: (){setState(() {
                            status = 0;
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
                                controller: emailInputController,
                                keyboardType: TextInputType.emailAddress,
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
                                  hintText: 'Full Name',
                                  hintStyle: StyleConstants.loginHintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: StyleConstants.loginBoxDecorationStyle,
                              height: 60.0,
                              child: TextFormField(
                                controller: pwdInputController,
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
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
                                controller: pwdInputController,
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,
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
                      ],
                    ),

                    //SizedBox(height: MediaQuery.of(context).size.height / 5,),
                    SizedBox(height: 40.0,),

                    Container(
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

                  ],
                ),
              )
          )
      ),
    );
  }


}
