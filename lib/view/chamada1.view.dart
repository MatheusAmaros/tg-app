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
  List funcoes = ["matheus", "cabo"];

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
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: GestureDetector(
          child: ListView(
            children: [
              ChamadaItem(uuid: "teste", nome: funcoes[0], funcao: funcoes[1]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.list), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
