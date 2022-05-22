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

  bool presenca = false;
  String anoIngresso = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        automaticallyImplyLeading: false,
        title: Text(
          'Chamada - ',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [],
        centerTitle: false,
      ),
      body: Theme(
            data: ThemeData(
                unselectedWidgetColor: Colors.white,
            ), 
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('atiradores').where('pelotao', isEqualTo: int.parse(arguments['pelotao'])).snapshots(),
        builder: (_, snapshot){
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Erro");
          }
          return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index){
                      return CheckboxListTile(
                        title: Text(snapshot.data!.docs[index]['nome'], style: TextStyle(color: Colors.white)),
                        value: presenca,
                        onChanged: (value){
                          setState(() {
                            presenca = value!;
                          });
                        },
                        activeColor: Color.fromARGB(255, 25, 68, 0),
                      );
                    },
            );
        },
      )
      ),
    );
  }
}