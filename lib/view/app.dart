import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tg_app/view/login.view.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginWidget(),
      //routes: {
      //  '/login': (context) => LoginWidget(),
      //},
    );
  }
}
