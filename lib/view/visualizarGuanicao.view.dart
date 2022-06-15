import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:tg_app/view/alteracaoGuarnicaoComandantes.view.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requisicao01();
  }

  requisicao01() async {
    await firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
        .get()
        .then((value) async {
      await firestore
          .collection("atiradores")
          .doc(value['uidComandante'])
          .get()
          .then((com) {
        setState(() {
          nomeCom = com["nome"];
        });
      });
      await firestore
          .collection("atiradores")
          .doc(value["uidCabo"])
          .get()
          .then((cabo) {
        setState(() {
          nomeCabo = cabo["nome"];
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

  TextStyle estilo = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  TextStyle estiloTitulo = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    while (map == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 51, 0),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(DateFormat('dd/MM/yyyy').format(widget.data).toString()),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        children: [
          InputDecorator(
            decoration: InputDecoration(
              labelText: "Comandante da Guarda",
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 7, 63, 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 7, 63, 0),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: []),
              child: Column(
                children: [
                  Text(
                    nomeCom.toString(),
                    style: estilo,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InputDecorator(
            decoration: InputDecoration(
              labelText: "Cabo da Guarda",
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 7, 63, 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 7, 63, 0),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: []),
              child: Column(
                children: [
                  Text(
                    nomeCabo.toString(),
                    style: estilo,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  shrinkWrap: true,
                  itemCount: map.length,
                  itemBuilder: (_, index) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Sentinela " + (index + 1).toString(),
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 7, 63, 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 7, 63, 0),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: []),
                        child: Column(
                          children: [
                            Text(
                              map[index]["nome"].toString(),
                              style: estilo,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => alteracaoGuarnicaoComandantes(
                          data: widget.data,
                        )));
              },
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 34, 2),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
              child: Text("Alterar Guarnição",
                  style: TextStyle(fontSize: 18, fontFamily: 'Montserrat')))
        ],
      ),
    );
  }
}
