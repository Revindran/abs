import 'package:absolute_solutions/login/Auth/Login.dart';
import 'package:absolute_solutions/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../login/Constant/assets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Home extends StatefulWidget {
  static final String path = "lib/src/pages/lists/grid_view.dart";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _listItem = [
    kathmandu1,
    fewalake,
    tokyo,
    mountEverest,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Welcome",
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/animation_500_knvbc9jl.gif'),
                        fit: BoxFit.fitHeight)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                          LinearGradient(begin: Alignment.bottomRight, colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Absolute Solutions',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(child: gridViewData())
            ],
          ),
        ),
      ),
    );
  }
}

Widget gridViewData() {
  final titles = [
    'Service list',
    'Customer list',
    'Reminder',
    // 'Logout',
  ];
  final categories = [
    'assets/images/service.jpeg',
    'assets/images/cu.png',
    'assets/images/re.png',
    // 'assets/images/Logout.png'
  ];
  GetStorage s = GetStorage();

  final routes = [
    Routes.service,
    Routes.Cl,
    Routes.UD,
    // Routes.login
  ];
  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 4,
    itemCount: titles.length,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(routes[index]);
        },
        child: Container(
          height: MediaQuery.of(context).size.width * 0.75,
          width: MediaQuery.of(context).size.width * 0.50,
          margin: EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(categories[index]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 50,
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 10, bottom: 0.5),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(11),
                              bottomRight: Radius.circular(11)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 20, bottom: 5),
                child: Text(
                  titles[index],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      );
    },
    staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, index.isEven ? 2 : 2),
    mainAxisSpacing: 5.0,
    crossAxisSpacing: 5.0,
  );
}
