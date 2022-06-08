import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:tg_app/view/cadastroGuarnicaoPrimeira.view.dart';

class CadastroGuarnicaoComandantes extends StatefulWidget {
  final DateTime data;
  CadastroGuarnicaoComandantes({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CadastroGuarnicaoComandantes> createState() =>
      _CadastroGuarnicaoCompletaState();
}

class _CadastroGuarnicaoCompletaState
    extends State<CadastroGuarnicaoComandantes> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> Atiradores = [];
  List<String> Selecionados = [];
  List<Map<String, dynamic>> Cabo = [];
  List<Map<String, dynamic>> Comandante = [];
  String? dropdownValue = '';
  Color? cor;

  var selectedCurrency, selectedComandante, selectedCabo = null;
  late String? date = DateFormat("dd/MM/yyyy").format(widget.data).toString();

  Map<dynamic, dynamic> map = {};
  String nomeCabo = "";
  String nomeCom = "";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    return menuItems;
  }

  void guardarSelecionados(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Selecionados.add(selectedComandante);
      Selecionados.add(selectedCabo);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CadastroGuarnicaoCompleta(
              data: widget.data, selecionados: Selecionados)));
    }
  }

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

  //Inserir comandante e cabo na data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Ink(
      color: Color.fromARGB(255, 0, 0, 0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
                Text(
                  "Guarnição: " + date.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection("atiradores")
                                .where("funcao", isEqualTo: "Comandante")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                const Text("Loading.....");
                              else {
                                List<DropdownMenuItem> currencyItems = [];
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  DocumentSnapshot snap =
                                      snapshot.data!.docs[i];
                                  currencyItems.add(
                                    DropdownMenuItem(
                                        child: Text(
                                          snapshot.data!.docs[i]['nome'],
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        value: "${snapshot.data!.docs[i].id}"),
                                  );
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Comandante:",
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    DropdownButtonFormField<dynamic>(
                                      items: currencyItems,
                                      value: selectedComandante,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 241, 240, 240)),
                                        hintText: "Name",
                                        fillColor:
                                            Color.fromARGB(255, 190, 190, 190),
                                      ),
                                      validator: (value) {
                                        if (value == null)
                                          return "selecione o Monitor";
                                        return null;
                                      },
                                      onChanged: (currencyValue) {
                                        setState(() {
                                          selectedComandante = currencyValue;
                                          final splitted =
                                              selectedComandante.split(',');
                                          print(splitted); // [Hello, world!];
                                        });
                                      },
                                      isExpanded: false,
                                      hint: new Text(
                                        "Selecione o Comandante",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              }
                              return Container();
                            }),
                        Container(
                          width: 350,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection("atiradores")
                                  .where("funcao", isEqualTo: "Comandante")
                                  .orderBy("DtUltimaGuardaPreta",
                                      descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Text("Loading.....");
                                else {
                                  return ListView.builder(
                                    reverse: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      var date = DateFormat("dd/MM/yyyy")
                                          .format(snapshot
                                              .data!
                                              .docs[index]
                                                  ['DtUltimaGuardaPreta']
                                              .toDate())
                                          .toString();

                                      return LineUltimaGuarda(
                                          snapshot, index, date);
                                    },
                                  );
                                }
                              }),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 350,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection("atiradores")
                                  .where("funcao", isEqualTo: "Comandante")
                                  .orderBy("DtUltimaGuardaVermelha",
                                      descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Text("Loading.....");
                                else {
                                  return ListView.builder(
                                    reverse: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      var date = DateFormat("dd/MM/yyyy")
                                          .format(snapshot
                                              .data!
                                              .docs[index]
                                                  ['DtUltimaGuardaVermelha']
                                              .toDate())
                                          .toString();

                                      return LineUltimaGuardaVermelha(
                                          snapshot, index, date);
                                    },
                                  );
                                }
                              }),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection("atiradores")
                                .where("funcao", isEqualTo: "Cabo")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                const Text("Carregando.....");
                              else {
                                List<DropdownMenuItem> currencyItems = [];
                                for (int i = 0;
                                    i < snapshot.data!.docs.length;
                                    i++) {
                                  DocumentSnapshot snap =
                                      snapshot.data!.docs[i];
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snapshot.data!.docs[i]['nome'],
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      value: "${snapshot.data!.docs[i].id}",
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      "Cabo da Guarda:",
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    DropdownButtonFormField<dynamic>(
                                      items: currencyItems,
                                      value: selectedCabo,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 241, 240, 240)),
                                        hintText: "Name",
                                        fillColor:
                                            Color.fromARGB(255, 190, 190, 190),
                                      ),
                                      validator: (value) {
                                        if (value == null)
                                          return "selecione o Cabo";
                                        return null;
                                      },
                                      onChanged: (currencyValue) {
                                        setState(() {
                                          selectedCabo = currencyValue;
                                        });

                                        ;
                                      },
                                      isExpanded: false,
                                      hint: new Text(
                                        "Selecione o Cabo",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 350,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection("atiradores")
                                  .where("funcao", isEqualTo: "Cabo")
                                  .orderBy("DtUltimaGuardaPreta",
                                      descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Text("Loading.....");
                                else {
                                  return ListView.builder(
                                    reverse: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      var date = DateFormat("dd/MM/yyyy")
                                          .format(snapshot
                                              .data!
                                              .docs[index]
                                                  ['DtUltimaGuardaPreta']
                                              .toDate())
                                          .toString();
                                      return LineUltimaGuarda(
                                          snapshot, index, date);
                                    },
                                  );
                                }
                              }),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 350,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection("atiradores")
                                  .where("funcao", isEqualTo: "Cabo")
                                  .orderBy("DtUltimaGuardaVermelha",
                                      descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Text("Loading.....");
                                else {
                                  return ListView.builder(
                                    reverse: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index) {
                                      var date = DateFormat("dd/MM/yyyy")
                                          .format(snapshot
                                              .data!
                                              .docs[index]
                                                  ['DtUltimaGuardaVermelha']
                                              .toDate())
                                          .toString();
                                      return LineUltimaGuardaVermelha(
                                          snapshot, index, date);
                                    },
                                  );
                                }
                              }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            guardarSelecionados(context);
                          },
                          child: Text("Confirmar"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            primary: Color.fromARGB(255, 59, 80, 57),
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            elevation: 15,
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            minimumSize: Size(400, 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Container LineUltimaGuardaVermelha(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index, String date) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(132, 244, 67, 54),
        border: Border(
          bottom: BorderSide(width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            snapshot.data!.docs[index]['nome'],
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          Text(
            "| Última Guarda: " + date.toString(),
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ],
      ),
    );
  }

  Container LineUltimaGuarda(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index, String date) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(83, 0, 0, 0),
        border: Border(
          bottom: BorderSide(width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            snapshot.data!.docs[index]['nome'],
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          Text(
            "| Última Guarda: " + date.toString(),
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ],
      ),
    );
  }
}

bool ehSabadoOuDomingo(DateTime data) {
  var diaDaSemana = data.weekday;

  // O "weekday" de uma instancia de data retorna um
  // inteiro referente ao dia da semana. Sábado e domingo
  // são representados respectivamente por 6 e 7.
  return diaDaSemana == 6 || diaDaSemana == 7;
}

bool ehFeriado(DateTime data) {
  // Informar a lista de dias no ano que são considerados
  // feriados nacionais. Vai ser necessário pesquisar quais são
  // e ir inserindo aqui nesta lista. Coloquei apenas alguns exemplos
  var diasDeFeriado = [
    DateTime(2022, 06, 16),
    DateTime(2022, 09, 07),
    DateTime(2022, 10, 12),
    DateTime(2022, 11, 02),
    DateTime(2022, 11, 15),
    DateTime(2022, 11, 20),
    DateTime(2022, 12, 24),
    DateTime(2022, 12, 25),
    DateTime(2022, 12, 31),
  ];
  print(diasDeFeriado.contains(data));
  return diasDeFeriado.contains(data);
}