import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChamadaView extends StatefulWidget {

  ChamadaView({Key? key}) : super(key: key);

  @override
  State<ChamadaView> createState() => _ChamadaViewState();
}

class _ChamadaViewState extends State<ChamadaView> {
  final firestore = FirebaseFirestore.instance;

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
              itemBuilder: (_, index){
                return CheckboxListTile(
                  title: snapshot.data!.docs[index].data()['nome'],
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