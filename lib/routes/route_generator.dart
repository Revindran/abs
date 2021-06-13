import 'package:absolute_solutions/Remainder/AddRemainder.dart';
import 'package:absolute_solutions/UI/Home.dart';
import 'package:absolute_solutions/UI/service_list.dart';
import 'package:absolute_solutions/login/Auth/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../UI/customer_list.dart';
import '../UI/splash_page.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => SplashPage());
      case Routes.login:
        return CupertinoPageRoute(builder: (_) => Login());
      case Routes.home:
        return CupertinoPageRoute(builder: (_) => Home());
      case Routes.Cl:
        return CupertinoPageRoute(builder: (_) => RiderList());
      case Routes.UD:
        return CupertinoPageRoute(builder: (_) => AddNewMedicine());
      case Routes.service:
        return CupertinoPageRoute(builder: (_) => ServiceScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
