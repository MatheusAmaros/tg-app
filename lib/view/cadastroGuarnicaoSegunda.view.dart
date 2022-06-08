import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class CadastroGuarnicaoSegunda extends StatefulWidget {
  final DateTime data;
  final List<String>? Selecionados;
  CadastroGuarnicaoSegunda(
      {Key? key, required this.data, required this.Selecionados})
      : super(key: key);

  @override
  State<CadastroGuarnicaoSegunda> createState() =>
      _CadastroGuarnicaoCompletaState();
}

class _CadastroGuarnicaoCompletaState extends State<CadastroGuarnicaoSegunda> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> Atiradores = [];
  List<Map<String, dynamic>> Cabo = [];
  List<Map<String, dynamic>> Comandante = [];
  String? dropdownValue = '';
  Map<dynamic, dynamic> map = {};
  final formKey = GlobalKey<FormState>();
  late String? date = DateFormat("dd/MM/yyyy").format(widget.data).toString();
  var selectedCurrency,
      selectedComandante,
      selectedCabo,
      selected1,
      selected2,
      selected3,
      selected4,
      selected5,
      selected6;
  late DateTime DataGuarnicao = widget.data;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    return menuItems;
  }

  void saveGuarnicaoPreta(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var a = await firestore
          .collection('guardas')
          .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
          .get();
      if (a.exists) {
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .update({
          'uidComandante': widget.Selecionados![0],
          'uidCabo': widget.Selecionados![1],
        });
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![0])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![1])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![2])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela1')
            .update({'uid': widget.Selecionados![2]});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![3])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela2')
            .update({'uid': widget.Selecionados![3]});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![4])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela3')
            .update({'uid': widget.Selecionados![4]});
        firestore
            .collection('atiradores')
            .doc(selected4)
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela4')
            .update({'uid': selected4});
        firestore
            .collection('atiradores')
            .doc(selected5)
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela5')
            .update({'uid': selected5});
        firestore
            .collection('atiradores')
            .doc(selected6)
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela6')
            .update({'uid': selected6});
      } else {
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .set({
          'uidComandante': widget.Selecionados![0],
          'uidCabo': widget.Selecionados![1],
        });
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![0])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![1])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![2])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela1')
            .set({'uid': widget.Selecionados![2]});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![3])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela2')
            .set({'uid': widget.Selecionados![3]});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![4])
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela3')
            .set({'uid': widget.Selecionados![4]});
        firestore
            .collection('atiradores')
            .doc(selected4)
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela4')
            .set({'uid': selected4});
        firestore
            .collection('atiradores')
            .doc(selected5)
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela5')
            .set({'uid': selected5});
        firestore
            .collection('atiradores')
            .doc(selected6)
            .update({'DtUltimaGuardaPreta': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela6')
            .set({'uid': selected6});
      }
      Navigator.pushNamed(context, '/home');
    }

    //Inserir comandante e cabo na data
  }

  void saveGuarnicaoVermelha(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var a = await firestore
          .collection('guardas')
          .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
          .get();
      if (a.exists) {
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .update({
          'uidComandante': widget.Selecionados![0],
          'uidCabo': widget.Selecionados![1],
        });
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![0])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![1])
            .update({'DtUltimaGuardaVermelha': widget.data});

        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![2])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela1')
            .update({'uid': widget.Selecionados![2]});

        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![3])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela2')
            .update({'uid': widget.Selecionados![3]});

        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![4])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela3')
            .update({'uid': widget.Selecionados![4]});

        firestore
            .collection('atiradores')
            .doc(selected4)
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela4')
            .update({'uid': selected4});

        firestore
            .collection('atiradores')
            .doc(selected5)
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela5')
            .update({'uid': selected5});

        firestore
            .collection('atiradores')
            .doc(selected6)
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela6')
            .update({'uid': selected6});
      } else {
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .set({
          'uidComandante': widget.Selecionados![0],
          'uidCabo': widget.Selecionados![1],
        });
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![0])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![1])
            .set({'DtUltimaGuardaVermelha': widget.data});

        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![2])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela1')
            .set({'uid': widget.Selecionados![2]});

        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![3])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela2')
            .set({'uid': widget.Selecionados![3]});

        firestore
            .collection('atiradores')
            .doc(widget.Selecionados![4])
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela3')
            .set({'uid': widget.Selecionados![4]});

        firestore
            .collection('atiradores')
            .doc(selected4)
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela4')
            .set({'uid': selected4});

        firestore
            .collection('atiradores')
            .doc(selected5)
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela5')
            .set({'uid': selected5});

        firestore
            .collection('atiradores')
            .doc(selected6)
            .update({'DtUltimaGuardaVermelha': widget.data});
        firestore
            .collection('guardas')
            .doc(DateFormat('yyyy-MM-dd').format(widget.data).toString())
            .collection('guarnicao')
            .doc('Sentinela6')
            .set({'uid': selected6});
      }
      Navigator.pushNamed(context, '/home');
    }

    //Inserir comandante e cabo na data
  }

  PegarSelecionados() async {
    await firestore
        .collection('guardas')
        .doc('2022-06-10')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
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
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection("atiradores")
                                .where("funcao", isEqualTo: "Sentinela")
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
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                      value: "${snapshot.data!.docs[i].id}",
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "4º Sentinela:",
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
                                      value: selected4,
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
                                            Color.fromARGB(90, 27, 134, 0),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return "selecione o sentinela";
                                        } else if (value == selected5 ||
                                            value == selected6) {
                                          return "Não é possível repetir o mesmo atirador";
                                        } else if (widget.Selecionados!.any(
                                            (element) => element == value)) {
                                          return "atirador selecionado na tela anterior";
                                        }

                                        return null;
                                      },
                                      onChanged: (currencyValue) {
                                        setState(() {
                                          selected4 = currencyValue;
                                          print(selected4);
                                        });
                                      },
                                      isExpanded: false,
                                      hint: new Text(
                                        "Selecione o Sentinela",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
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
                                .where("funcao", isEqualTo: "Sentinela")
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
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                      value: "${snapshot.data!.docs[i].id}",
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "5º Sentinela:",
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
                                      value: selected5,
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
                                            Color.fromARGB(90, 27, 134, 0),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return "selecione o sentinela";
                                        } else if (value == selected1 ||
                                            value == selected2 ||
                                            value == selected3 ||
                                            value == selected4 ||
                                            value == selected6) {
                                          return "Não é possível repetir o mesmo atirador";
                                        }

                                        return null;
                                      },
                                      onChanged: (currencyValue) {
                                        setState(() {
                                          selected5 = currencyValue;
                                          print(selected5);
                                        });
                                      },
                                      isExpanded: false,
                                      hint: new Text(
                                        "Selecione o Sentinela",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
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
                                .where("funcao", isEqualTo: "Sentinela")
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
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                      value: "${snapshot.data!.docs[i].id}",
                                    ),
                                  );
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "6º Sentinela:",
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
                                      value: selected6,
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
                                            Color.fromARGB(90, 27, 134, 0),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return "selecione o Sentinela";
                                        } else if (value == selected1 ||
                                            value == selected2 ||
                                            value == selected3 ||
                                            value == selected4 ||
                                            value == selected5) {
                                          return "Não é possível repetir o mesmo atirador";
                                        }

                                        return null;
                                      },
                                      onChanged: (currencyValue) {
                                        setState(() {
                                          selected6 = currencyValue;
                                          print(selected6);
                                        });
                                      },
                                      isExpanded: false,
                                      hint: new Text(
                                        "Selecione o Sentinela",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 370,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                              top: BorderSide(width: 1.0, color: Colors.black),
                              left: BorderSide(width: 1.0, color: Colors.black),
                              right:
                                  BorderSide(width: 1.0, color: Colors.black),
                            ),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection("atiradores")
                                  .where("funcao", isEqualTo: "Sentinela")
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
                          width: 370,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                              top: BorderSide(width: 1.0, color: Colors.black),
                              left: BorderSide(width: 1.0, color: Colors.black),
                              right:
                                  BorderSide(width: 1.0, color: Colors.black),
                            ),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection("atiradores")
                                  .where("funcao", isEqualTo: "Sentinela")
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
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            var diaUtil = !ehSabadoOuDomingo(widget.data) &&
                                !ehFeriado(widget.data);
                            if (diaUtil) {
                              saveGuarnicaoPreta(context);
                            } else {
                              saveGuarnicaoVermelha(context);
                            }
                          },
                          child: Text("Cadastrar guarnição"),
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
  // e ir inserindo aqui nesta lista. Coloquei apenas alguns exemplos.
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

  return diasDeFeriado.contains(data);
}
