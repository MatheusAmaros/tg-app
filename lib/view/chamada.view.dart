import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tg_app/model/atirador.model.dart';

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
  String anoIngresso = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('atiradores').snapshots(),
        builder: (_, snapshot){
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Erro");
          }
          return Column(
            children: [
              DropdownButton(
                underline: Container(),
                isExpanded: true,
                items: dropdownItems,
                value: pelotao,
                onChanged: (String? value) {
                  setState(() {
                    pelotao =  value!;
                  }); 
                },
              ),
              /*Expanded(
                child: SizedBox(
                  height: 200,
                  child:*/ ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index){
                      return CheckboxListTile(
                        title: Text(snapshot.data!.docs[index]['nome']),
                        value: presenca,
                        onChanged: (value){
                          setState(() {
                            presenca = value!;
                          });
                        }
                      );
                    },
                  ),
               // ),
             // )
            ],
          );
        },
      )
    );
  }
}