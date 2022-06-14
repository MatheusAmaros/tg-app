import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChamadaView extends StatefulWidget {
  
  ChamadaView({Key? key}) : super(key: key);

  @override
  State<ChamadaView> createState() => _ChamadaViewState();
}

class _ChamadaViewState extends State<ChamadaView> {
  final firestore = FirebaseFirestore.instance;

  bool presenca = false;
  String anoIngresso = DateTime.now().year.toString();
  bool value1 = true;

  void verificaChamada(pelotaoBusca, dataInv) async {
    await firestore.collection('chamadas').doc(dataInv).collection(pelotaoBusca).get()
    .then((val){
      if(val.docs.length == 0){
        cadastrarAtiradores(pelotaoBusca, dataInv);
      } 
    });
  }

  void cadastrarAtiradores(pelotaoBusca, dataInv) {
    firestore.collection('atiradores').where('pelotao', isEqualTo: pelotaoBusca).get()
    .then((val){
      for (var element in val.docs) {
         firestore
          .collection("chamadas")
          .doc(dataInv)
          .collection(pelotaoBusca)
          .doc(element.data()["uid"])
          .set({
            'uid': element.data()["uid"],
            'nome': element.data()["nome"],
            'presenca': false
          });
      }  
    });
  }

  void salvarPresenca(pelotaoBusca, dataInv, uid, value) {
    firestore
      .collection("chamadas")
      .doc(dataInv)
      .collection(pelotaoBusca)
      .doc(uid)
      .update({
        'presenca': value
      });
  }

  void logout() async {
    FirebaseAuth user = FirebaseAuth.instance;
    await user.signOut();

    setState(() {
      Navigator.pop(context);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final numPelotao = arguments['pelotao'];
    final pelotaoBusca = 'pelotao$numPelotao';
    String dataInv = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    verificaChamada(pelotaoBusca, dataInv);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 34, 2),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.dstATop),
            image: Image.asset('assets/images/camuflagem2.jpg',).image,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text('Chamada', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Montserrat-S',)),
                      IconButton(
                        icon: Icon((Icons.perm_identity_sharp)),
                        iconSize: 30,
                        color: Colors.transparent,
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child:  Theme(
                  data: ThemeData(
                      unselectedWidgetColor: Colors.grey.shade900,
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
                      return Center(child: Text("Sem atiradores cadastrados para o pelotão selecionado."));
                    }

                    return ListView.builder( 
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index){
                        return CheckboxListTile(
                          title: Text(snapshot.data!.docs[index]['nome'], style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat-S')),
                          value: snapshot.data!.docs[index]['presenca'],
                          onChanged: (value){
                            setState(() {
                              salvarPresenca(pelotaoBusca, dataInv, snapshot.data!.docs[index]['uid'], value);
                            });
                          },
                          activeColor: Color.fromARGB(255, 8, 56, 11),
                        );
                      },
                      );
                    },
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
    /*
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 56, 11),
        //automaticallyImplyLeading: false,
        title: Text(
          'Chamada - Pelotão $numPelotao',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions:[],
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
            return Center(child: Text("Sem atiradores cadastrados para o pelotão selecionado."));
          }

          return ListView.builder( 
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index){
                return CheckboxListTile(
                  title: Text(snapshot.data!.docs[index]['nome'], style: TextStyle(color: Colors.white)),
                  value: snapshot.data!.docs[index]['presenca'],
                  onChanged: (value){
                    setState(() {
                      salvarPresenca(pelotaoBusca, dataInv, snapshot.data!.docs[index]['uid'], value);
                    });
                  },
                  activeColor: Color.fromARGB(255, 8, 56, 11),
                );
              },
            );
        },
      )
      ),
    );*/
  }
}