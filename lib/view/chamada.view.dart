import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tg_app/view/chamadaItem.view.dart';

class Chamada extends StatefulWidget {
  const Chamada({Key? key}) : super(key: key);

  @override
  _ChamadaState createState() => _ChamadaState();
}

class _ChamadaState extends State<Chamada> {
  bool checkboxListTileValue = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'Chamada',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [],
        centerTitle: false,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ChamadaItem(),
              ChamadaItem(),
              ChamadaItem()
            ],
          ),
        ),
      ),
    );
  }
}
