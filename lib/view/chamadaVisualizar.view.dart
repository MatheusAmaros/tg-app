import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChamadaVizualizarView extends StatefulWidget {
  
  ChamadaVizualizarView({Key? key}) : super(key: key);

  @override
  State<ChamadaVizualizarView> createState() => _ChamadaVizualizarViewState();
}

class _ChamadaVizualizarViewState extends State<ChamadaVizualizarView> {
  final firestore = FirebaseFirestore.instance;

  bool presenca = false;
  String anoIngresso = DateTime.now().year.toString();
  bool value1 = true;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final numPelotao = arguments['pelotao'];
    final pelotaoBusca = 'pelotao$numPelotao';
    final dataInv = DateFormat("yyyy-MM-dd").format(DateTime.parse(arguments['dataInv'])).toString();
    final dataText = arguments['dataText'];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 56, 11),
        automaticallyImplyLeading: true,
        title: Text(
          'Chamada',
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
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Erro");
          }
          if(snapshot.data!.docs.length == 0){
            return Center(child: Text("Sem chamada cadastrada."));
          }

          return Column(
            children:[
              Text("Pelotão $numPelotao - $dataText", style: TextStyle(color: Colors.white),),
              ListView.builder( 
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index){
                  return CheckboxListTile(
                    title: Text(snapshot.data!.docs[index]['nome'], style: TextStyle(color: Colors.white)),
                    value: snapshot.data!.docs[index]['presenca'],
                    activeColor: Color.fromARGB(255, 8, 56, 11), 
                    onChanged: (value){},
                  );
                },
              ),
            ]
          );
        },
      )
      ),
    );
  }
}