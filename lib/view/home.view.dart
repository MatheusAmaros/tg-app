import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(children: [

        IconButton(onPressed: (){}, icon: Icon(Icons.abc))
      ]),
    );
      
    
  }
}
