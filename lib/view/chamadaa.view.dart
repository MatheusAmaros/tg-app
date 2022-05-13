import 'package:flutter/material.dart';
import 'package:tg_app/view/chamadaItem.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chamadaa extends StatefulWidget {

  Chamadaa({Key? key}) : super(key: key);

  @override
  _ChamadaaState createState() => _ChamadaaState();
}

class _ChamadaaState extends State<Chamadaa> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Pelotão 1"), value: "pelotao1"),
      const DropdownMenuItem(child: Text("Pelotão 2"), value: "pelotao2"),
      const DropdownMenuItem(child: Text("Pelotão 3"), value: "pelotao3"),
    ];
    return menuItems;
  }

  String pelotao ='pelotao1';
  bool presenca = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('atiradores').doc('pelotao1').collection('2022').snapshots(),
        builder: (_, snapshot){
          return Column(children: [
            DropdownButton(
              isExpanded: true,
              items: dropdownItems,
              value: pelotao,
              onChanged: (String? value) {
                setState(() {
                  pelotao =  value!;
                }); 
              },
            ),
            ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index){
              var item = widget.itens[index];
                return CheckboxListTile(
                  title: Text(nome),
                  value: presenca,
                  onChanged: (value){
                    setState(() {
                      presenca = value!;
                    });
                  }
                );
              },
            )
          ],
          );
        },
      )
    );
  }
}