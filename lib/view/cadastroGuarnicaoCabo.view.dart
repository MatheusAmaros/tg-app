import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CadastroGuarnicaoCabo extends StatefulWidget {
  final String? Name;
  String? nome;
  final List<String>? lista;

  CadastroGuarnicaoCabo({Key? key, @required this.Name, this.nome, this.lista})
      : super(key: key);

  @override
  State<CadastroGuarnicaoCabo> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CadastroGuarnicaoCabo> {
  late String dropdownValue = widget.lista![0];
  final firestore = FirebaseFirestore.instance;
  DateTime data = DateTime.now();

  void saveCabo(BuildContext context) async {
    firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(data))
        .collection('guarnicao')
        .doc('Cabo')
        .set({'uid': "Salva ai mano", 'nome': dropdownValue});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Cabo da guarda",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple, fontSize: 25),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  widget.nome = newValue;
                  //print(widget.key);
                });
              },
              items: widget.lista!.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem(
                  value: value,
                  key: widget.key,
                  child: Column(
                    children: [
                      Text(value),
                    ],
                  ),
                  onTap: () {},
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () {
                  saveCabo(context);
                },
                child: Text("Confirmar")),
          ],
        ),
      ],
    );
  }
}