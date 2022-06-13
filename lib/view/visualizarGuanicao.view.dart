import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
/*
class VisualizacaoGuarnicao extends StatefulWidget {
  const VisualizacaoGuarnicao({Key? key}) : super(key: key);

  @override
  State<VisualizacaoGuarnicao> createState() => _VisualizacaoGuarnicaoState();
}

class _VisualizacaoGuarnicaoState extends State<VisualizacaoGuarnicao> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('guardas')
                    .doc('2022-06-10')
                    .collection('guarnicao')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    const Text("Loading.....");
                  } else {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      ItemNome(item: snapshot.data!.docs[i]);
                    }
                  }
                  return Container(
                    child: Text('Teset'),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class ItemNome extends StatelessWidget {
  var item;
  ItemNome({Key? key, required this.item}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    print(item['uid']);
    return Container(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection('atiradores')
                .where('uid', isEqualTo: item['uid'])
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                const Text("Loading.....");
              } else {
                return Text(snapshot.data!.docs[0]['nome']);
              }
              return Text(snapshot.data!.docs[0]['nome']);
            }));
  }
}*/

class VisualizacaoGuarnicao extends StatefulWidget {
  final DateTime data;
  const VisualizacaoGuarnicao({Key? key, required this.data}) : super(key: key);

  @override
  State<VisualizacaoGuarnicao> createState() => _VisualizacaoGuarnicaoState();
}

class _VisualizacaoGuarnicaoState extends State<VisualizacaoGuarnicao> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<dynamic, dynamic> map = {};
  String nomeCabo = "";
  String nomeCom = "";

  //   requisicaoComando() async {
  //   await firestore
  //       .collection('guardas')
  //       .doc('2022-06-10')
  //       .get()
  //       .then((value) async {
  //       map[i] = value.docs[i].data();
  //       print(value.docs[i]["uid"]);

  //       await firestore
  //           .collection('atiradores')
  //           .doc(value['uid'])
  //           .get()
  //           .then((value02) {
  //         print(value02['nome']);
  //         map[i] = value02.data();
  //       });

  //   });
  //   setState(() {
  //     map = map;
  //   });
  // }

  requisicao01() async {
    await firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
        .get()
        .then((value) async {
      await firestore
          .collection("atiradores")
          .doc(value['uidCabo'])
          .get()
          .then((cabo) {
        setState(() {
          nomeCabo = cabo["nome"];
        });
      });
      await firestore
          .collection("atiradores")
          .doc(value['uidComandante'])
          .get()
          .then((com) {
        setState(() {
          nomeCom = com["nome"];
        });
      });
    });
    await firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
        .collection('guarnicao')
        .get()
        .then((value) async {
      for (var i = 0; i < value.docs.length; i++) {
        // map[i] = value.docs[i].data();
        //print(value.docs[i]["uid"]);
        await firestore
            .collection('atiradores')
            .doc(value.docs[i]['uid'])
            .get()
            .then((value02) {
          // print(value02['nome']);
          map[i] = value02.data();
        });
      }
    });
    setState(() {
      map = map;
    });
  }

  TextStyle stylo = const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
  @override
  Widget build(BuildContext context) {
    requisicao01();
    while (map == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
      children: [
        Container(
          // width: 500,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Text(
                "Comandante",
                style: stylo,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                nomeCom.toString(),
                style: stylo,
              ),
            ],
          ),
        ),
        Container(
          width: 500,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Text(
                "Cabo da Guarda",
                style: stylo,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                nomeCabo.toString(),
                style: stylo,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            shrinkWrap: true,
            itemCount: map.length,
            itemBuilder: (_, index) {
              return Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      "Sentinela",
                      style: stylo,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      map[index]["nome"].toString(),
                      style: stylo,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
