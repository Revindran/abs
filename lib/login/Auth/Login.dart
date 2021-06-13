import 'dart:convert';

import 'package:absolute_solutions/Model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'SignUpPage.dart';
import 'package:flutter/material.dart';
import '../../UI/Home.dart';
import '../Animation/AnimationBuildLogin.dart';
import '../Constant/ColorGlobal.dart';
import '../Constant/TextField.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  bool showvalue = false;
  bool _isLoading = false;
  double width = 400.0;
  double widthIcon = 180.0;
  TextEditingController emailcontroler = new TextEditingController();
  TextEditingController passwordcontroler = new TextEditingController();

  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  LoginModel loginRequest;

  String username;

  GetStorage storage = GetStorage();

  getDisposeController() {
    emailcontroler.clear();
    passwordcontroler.clear();
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginRequest = new LoginModel();
    //getDisposeController();
  }

  @override
  void dispose() {
    //getDisposeController();
    // TODO: implement dispose
    super.dispose();
  }

  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: ColorGlobal.whiteColor,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(),
                height: size.height,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.blue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
//                top: keyboardOpen ? -size.height / 3.2 : 0.0,
                child: AnimationBuildLogin(
                  size: size,
                  yOffset: size.height / (1.15),
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: (90)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/AS.png',
                      color: Colors.indigo,
                      height: 150,
                      width: 150,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Padding(
                padding: EdgeInsets.only(top: (250)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Absolute Solutions',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 24.0,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 22,
                  left: 22,
                  bottom: 22,
                  top: 300,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TextFieldWidget(
                        hintText: 'User Name',
                        obscureText: false,
                        prefixIconData: Icons.person,
                        textEditingController: emailcontroler,
                        focusNode: emailFocus,
                        onChanged: (val) {
                          setState(() {
                            username = emailcontroler.value.text;
                          });
                          print("CHANGES ${val} ===> ${emailcontroler.text}");
                        },
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Container(
                      child: TextFieldWidget(
                        hintText: 'Password',
                        obscureText: false,
                        prefixIconData: Icons.lock,
                        textEditingController: passwordcontroler,
                        focusNode: passwordFocus,
                        onChanged: (val) {
                          setState(() {
                            // password = password.value.text;
                          });
                          // print("CHANGES ${val} ===> ${email.text}");
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(
                        top: (40),
                        right: (8),
                        left: (8),
                        bottom: (20),
                      ),
                      child:
                      _isLoading?Center(child: CircularProgressIndicator()):loginButtonUI(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButtonUI() {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          _validateAndAuth(emailcontroler.text, passwordcontroler.text);
        },
        child: Hero(
          tag: 'blackBox',
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: ColorGlobal.colorPrimaryDark,
                shape: BoxShape.circle,
              ),
            );
          },
          child: Container(
            height: (60.0),
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.blueAccent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorGlobal.colorPrimary.withOpacity(0.6),
                    spreadRadius: 5,
                    blurRadius: 20,
                    // changes position of shadow
                  ),
                ],
                border: Border.all(
                  width: 2,
                  color:
                      Colors.black, //                   <--- border width here
                ),
                color: ColorGlobal.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular((22.0)))),
            child: Container(
//                        margin: EdgeInsets.only(left: (10)),
              alignment: Alignment.center,
              child: Text(
                "PROCEED",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndAuth(String email, pass) {
    if (email.isEmpty || pass.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Please Fill all the fields..',
        'Please Fill all the fields...',
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      setState(() {
        _isLoading = true;
      });
      signIn(email, pass);
    }
  }

  signIn(String email, pass) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((result) {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar(
            'User Signing Successful..', 'User Signing Successfully Completed',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: Get.theme.snackBarTheme.backgroundColor,
            colorText: Get.theme.snackBarTheme.actionTextColor);
        storage.write('email', email);
        Get.offAll(() => Home());
      });
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Sign In Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}
