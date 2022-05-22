import 'dart:html';

import 'package:flutter/material.dart';

class ChamadaPelotaoView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 56, 11),
        automaticallyImplyLeading: false,
        title: Text(
          'Selecione o pelotão',
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
      body: ListView(
        children: <Widget>[
          ListTile( 
            title: Text("Pelotão 1", style: TextStyle(color: Colors.white)), 
            trailing: Icon(Icons.chevron_right, color: Colors.white), 
            onTap: (){
              Navigator.of(context).pushNamed('/chamada', arguments: {'pelotao': '1'});
            }),
          ListTile( 
            title: Text("Pelotão 2", style: TextStyle(color: Colors.white)),
            trailing: Icon(Icons.chevron_right, color: Colors.white), 
            onTap: (){
              Navigator.of(context).pushNamed('/chamada', arguments: {'pelotao': '2'});
            }),
          ListTile( 
            title: Text("Pelotão 3", style: TextStyle(color: Colors.white)), 
            trailing: Icon(Icons.chevron_right, color: Colors.white), 
            onTap: (){
              Navigator.of(context).pushNamed('/chamada', arguments: {'pelotao': '3'});
            }),
          ListTile( 
            title: Text("Pelotão 4", style: TextStyle(color: Colors.white)), 
            trailing: Icon(Icons.chevron_right, color: Colors.white), 
            onTap: (){
              Navigator.of(context).pushNamed('/chamada', arguments: {'pelotao': '4'});
            })
        ],
      ),
    );
  }
}