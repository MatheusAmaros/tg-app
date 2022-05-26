import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void carrega() async {
      //final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

      FirebaseFirestore db = FirebaseFirestore.instance;
      /*
    //retornando lista de documentos
    var collection = db.collection('atiradores');
    var result = await collection.get();
    for(var docs in result.docs)
    {
      print(docs['nome']);
    }

    //retornando 1 unico documento
    var user = await db.collection('atiradores').doc(arguments['userUid']).get();
    var usuario = user['nome'];
    print(usuario);*/

      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String datenow = formatter.format(now);
      print(datenow); // something like 2013-04-20

      var user = await db.collection('chamada').doc(datenow).get();

      print(user['01'][0]);
      print(user['01'][1]);
    }

    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  carrega();
                                },
                                iconSize: 50,
                                icon: Icon(Icons.abc)),
                            Text('Chamada')
                          ],
                        ),
                      ],
                    ),

                                      Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  carrega();
                                },
                                iconSize: 50,
                                icon: Icon(Icons.abc)),
                            Text('Chamada')
                          ],
                        ),
                      ],
                    ),
              


                ]),
            ),
            
             Container(
               margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
               child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  carrega();
                                },
                                iconSize: 50,
                                icon: Icon(Icons.abc)),
                            Text('Chamada')
                          ],
                        ),
                      ],
                    ),

                                      Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  carrega();
                                },
                                iconSize: 50,
                                icon: Icon(Icons.abc)),
                            Text('Chamada')
                          ],
                        ),
                      ],
                    ),
              


                ]),
            ),

                
          ],
        ));
  }
}
