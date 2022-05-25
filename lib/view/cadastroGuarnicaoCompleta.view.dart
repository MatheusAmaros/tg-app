import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
/*
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
  String? dropdownValue = '';
  var selectedCurrency,
      selectedComandante,
      selectedCabo,
      selected1,
      selected2,
      selected3,
      selected4,
      selected5,
      selected6;
  String? data = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    return menuItems;
  }

  void saveGuarnicao(BuildContext context) async {
    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .set({
      'uidComandante': selectedComandante,
      'uidCabo': selectedCabo,
    });
    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela1')
        .set({'uid': selected1});
    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela2')
        .set({'uid': selected2});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela3')
        .set({'uid': selected3});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela4')
        .set({'uid': selected4});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela5')
        .set({'uid': selected5});

    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .collection('guarnicao')
        .doc('Sentinela6')
        .set({'uid': selected6});

    //Inserir comandante e cabo na data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              child: Image.asset('assets/images/ebLogo.png'),
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Guarnição: " + data.toString())],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Comandante")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Comandante:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selectedComandante,
                            onChanged: (currencyValue) {
                              setState(() {
                                selectedComandante = currencyValue;
                                print(selectedComandante);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Comandante",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Cabo")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Cabo da Guarda:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selectedCabo,
                            onChanged: (currencyValue) {
                              setState(() {
                                selectedCabo = currencyValue;
                                print(selectedCabo);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Cabo",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Sentinela")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("1º Sentinela:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selected1,
                            onChanged: (currencyValue) {
                              setState(() {
                                selected1 = currencyValue;
                                print(selected1);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Sentinela",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Sentinela")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("2º Sentinela:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selected2,
                            onChanged: (currencyValue) {
                              setState(() {
                                selected2 = currencyValue;
                                print(selected2);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Sentinela",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Sentinela")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("3º Sentinela:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selected3,
                            onChanged: (currencyValue) {
                              setState(() {
                                selected3 = currencyValue;
                                print(selected3);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Sentinela",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Sentinela")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("4º Sentinela:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selected4,
                            onChanged: (currencyValue) {
                              setState(() {
                                selected4 = currencyValue;
                                print(selected4);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Sentinela",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Sentinela")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("5º Sentinela:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selected5,
                            onChanged: (currencyValue) {
                              setState(() {
                                selected5 = currencyValue;
                                print(selected5);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Sentinela",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection("atiradores")
                      .where("função", isEqualTo: "Sentinela")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data!.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data!.docs[i]['nome'],
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data!.docs[i].id}",
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("6º Sentinela:"),
                          SizedBox(width: 5),
                          DropdownButton(
                            items: currencyItems,
                            value: selected6,
                            onChanged: (currencyValue) {
                              setState(() {
                                selected6 = currencyValue;
                                print(selected6);
                              });
                            },
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Sentinela",
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              ElevatedButton(
                onPressed: () => saveGuarnicao(context),
                child: Text("Cadastrar guarnição"),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: Color.fromARGB(255, 20, 66, 20),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ));
  }
}
*/