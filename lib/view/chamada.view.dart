import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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

  void CadastrarAtiradores(pelotaoBusca, dataInv) async {
    await firestore.collection('atiradores').where('pelotao', isEqualTo: pelotaoBusca).get()
    .then((val){
      for (var element in val.docs) {
        //print('aqui!!!! ${element.data()}');
         firestore
          .collection("chamadas")
          .doc(dataInv)
          .collection(pelotaoBusca)
          .doc(element.data()["uid"])
          .set({
            'uid': element.data()["uid"],
            'nome': element.data()["nome"],
            'presenca': false,
          });
      }
            
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final numPelotao = arguments['pelotao'];
    final pelotaoBusca = 'pelotao$numPelotao';
    String dataInv = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

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
        stream: firestore.collection('chamadas').doc(dataInv).collection(pelotaoBusca).snapshots(),
        builder: (_, snapshot){
          if(snapshot.data!.docs.length == 0){
            CadastrarAtiradores(pelotaoBusca, dataInv);
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
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