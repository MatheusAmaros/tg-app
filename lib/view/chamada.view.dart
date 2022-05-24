import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tg_app/model/atirador.model.dart';
import 'package:tg_app/model/chamada.model.dart';

class ChamadaView extends StatefulWidget {
  
  ChamadaView({Key? key}) : super(key: key);

  @override
  State<ChamadaView> createState() => _ChamadaViewState();
}

class _ChamadaViewState extends State<ChamadaView> {
  final firestore = FirebaseFirestore.instance;

  bool presenca = false;
  String anoIngresso = DateTime.now().year.toString();
  String ano = DateTime.now().year.toString();
  String mes = DateTime.now().month.toString();
  String dia = DateTime.now().day.toString();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final numPelotao = arguments['pelotao'];

    void buscaDados() async{
      var atiradores = await firestore.collection('atiradores').where('pelotao', isEqualTo: int.parse(numPelotao)).snapshots().toList();
      var chamada = await firestore.collection('chamada').doc('$dia-$mes-$ano').snapshots();
      print(chamada);
      /*if(chamada.isNotEmpty){
        for (var element in chamada) {
          print(element);
        }
      }*/
      //pesquisar se a chamada de hoje para esse pelotão já existe
      //se existir: chama a chamada
      //senão: setar a chamada do pelotão com todos os atiradores com falta
    }

  buscaDados();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 56, 11),
        automaticallyImplyLeading: false,
        title: Text(
          'Chamada - Pelotão $numPelotao',
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
        stream: firestore.collection('atiradores').where('pelotao', isEqualTo: int.parse(numPelotao)).snapshots(),
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
                      final item = snapshot.data!.docs[index];
                      return CheckboxListTile(
                        title: Text(snapshot.data!.docs[index]['nome'], style: TextStyle(color: Colors.white)),
                        value: presenca,
                        onChanged: (value){
                          setState(() {
                            presenca = value!;
                          });
                          //salvar atirador na chamada
                        },
                        activeColor: Color.fromARGB(255, 8, 56, 11),
                      );
                    },
            );
        },
      )
      ),
    );
  }
}