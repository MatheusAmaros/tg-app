import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:tg_app/view/cadastroGuarnicaoComandante.view.dart';

class CadastroGuarnicaoCompleta extends StatefulWidget {
  const CadastroGuarnicaoCompleta({Key? key}) : super(key: key);

  @override
  State<CadastroGuarnicaoCompleta> createState() =>
      _CadastroGuarnicaoCompletaState();
}

class _CadastroGuarnicaoCompletaState extends State<CadastroGuarnicaoCompleta> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> Atiradores = [];
  List<Map<String, dynamic>> Cabo = [];
  List<Map<String, dynamic>> Comandante = [];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    return menuItems;
  }

  void saveComandante(BuildContext context) async {
    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .set({
      'uidComandante': "testecomandante",
      'nomeComandante': "testecomandante",
      'uidCabo': "testeCabo",
      'nomeCabo': "testeCabo",
    });
    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela1')
        .set({'uid': "Sentinela1", 'nome': "Alves"});
    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela2')
        .set({'uid': "Sentinela2", 'nome': "Julio"});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela3')
        .set({'uid': "Sentinela3", 'nome': "Pedro"});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela4')
        .set({'uid': "Sentinela4", 'nome': "José"});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela5')
        .set({'uid': "Sentinela5", 'nome': "Padilha"});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela6')
        .set({'uid': "Sentinela6", 'nome': "Marcos"});

    //Inserir comandante e cabo na data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firestore.collection('atiradores').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return const Text('Erro ao carregar dados');
        if (!snapshot.hasData) return const CircularProgressIndicator();

        // print(snapshot.data!.docs[0].get(''));

        return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (_, index) {
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: snapshot.data!.docs[index].reference
                      .collection('2022')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError)
                      return const Text('Erro ao carregar dados');

                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      if (snapshot.data!.docs[i].data()['função'] == "cabo") {
                        var item = {
                          'nome': snapshot.data!.docs[i].data()['nome'],
                          'uid': snapshot.data!.docs[i].id
                        };
                        saveComandante(context);
                        Cabo.add(item);
                      }
                      if (snapshot.data!.docs[i].data()['função'] ==
                          "comandante") {
                        var item = {
                          'nome': snapshot.data!.docs[i].data()['nome'],
                          'uid': snapshot.data!.docs[i].id
                        };

                        Comandante.add(item);
                      }
                      if (snapshot.data!.docs[i].data()['função'] ==
                          "sentinela") {
                        var item = {
                          'nome': snapshot.data!.docs[i].data()['nome'],
                          'uid': snapshot.data!.docs[i].id
                        };
                        Atiradores.add(item);
                      }
                    }
                    return Column(
                      children: [
                        DropdownButton(
                            items: snapshot.data!.docs
                                .map(
                                  (map) => DropdownMenuItem(
                                    child: Text(map['nome']),
                                    value: map.id,
                                  ),
                                )
                                .toList(),
                            onChanged: (context) {
                              print("ola");
                            })
                        /*
                        Column(
                            children:
                                Cabo.map((e) => Text(e['nome'])).toList()),
                        Column(
                            children: Comandante.map((e) => Text(e['nome']))
                                .toList()),
                        Column(
                            children: Atiradores.map((e) => Text(e['nome']))
                                .toList()),
                                */
                      ],
                    );
                  });
            }
            //dropdownItems.add(snapshot.data!.docs[0][index]);

            );
      },
    ));
  }
}
