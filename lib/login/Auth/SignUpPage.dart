import 'package:absolute_solutions/UI/customer_list.dart';
import 'package:absolute_solutions/UI/Home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'Login.dart';
import '../Animation/AnimationBuildLogin.dart';
import '../Constant/ColorGlobal.dart';
import '../Constant/TextField.dart';
import '../Constant/frequentWidget.dart';

class SignUpPage extends StatefulWidget {


  @override
  SignUpPageState createState() {
    return new SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  double width = 200.0;
  double widthIcon = 180.0;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  FocusNode nameFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  FocusNode passwordFocus = new FocusNode();

  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        width = 190.0;
      });
    });
  }

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
                child: AnimationBuildLogin(
                  size: size,
                  yOffset: size.height / 1.26,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/AS.png',
                      height: 120,
                      width: 120,color: Colors.indigo,

                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 210.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Create Account !',
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
                padding: const EdgeInsets.only(
                  right: 22,
                  left: 22,
                  bottom: 22,
                  top: 270,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TextFieldWidget(
                        hintText: 'Name',
                        obscureText: false,
                        prefixIconData: Icons.account_circle,
                        textEditingController: name,
                        focusNode: nameFocus,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFieldWidget(
                        hintText: 'Email',
                        obscureText: false,
                        prefixIconData: Icons.email,
                        textEditingController: email,
                        focusNode: emailFocus,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFieldWidget(
                        hintText: 'Password',
                        obscureText: true,
                        prefixIconData: Icons.lock,
                        focusNode: passwordFocus,
                        textEditingController: password,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 400),
                                child: Home()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: (30),
                          right: (8),
                          left: (8),
                          bottom: (20),
                        ),
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
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 20,
                              // changes position of shadow
                            ),
                          ],
                          border: Border.all(
                            width: 2,
                            color: Colors.black, //                   <--- border width here
                          ),
                          color: Colors.black38,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              (22.0),
                            ),
                          ),
                        ),
                        child: Container(
//                        margin: EdgeInsets.only(left: (10)),
                          alignment: Alignment.center,
                          child: Text(
                            "SIGN UP",
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
                    InkWell(onTap:(){
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dummy(),));
                    },
                      child:Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        margin: EdgeInsets.only(
                          top: (40),
                          right: (8),
                          left: (8),
                          bottom: (20),
                        ),
                        child: Text('Click here to Login',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)/*AuthButton(username: username,)*/,
                      ),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
     /* bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 30),
        color: ColorGlobal.whiteColor,
        height: 70,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));

                  },
                  child: AnimatedContainer(
                    height: 65.0,
                    width: width,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.linear,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Have an Account",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    color:
                                        ColorGlobal.whiteColor.withOpacity(0.9),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
//                          margin: EdgeInsets.only(right: 8,top: 15),
                                child: Text(
                                  "Sign In",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1,
                                    color:
                                        ColorGlobal.whiteColor.withOpacity(0.9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: ColorGlobal.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.lightBlueAccent ,
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),*/

//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton.extended(
//
//          icon: Icon(Icons.update),
//          label: Text("Transform")),
    );
  }
}
