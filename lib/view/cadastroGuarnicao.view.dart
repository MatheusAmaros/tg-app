import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:tg_app/view/cadastroGuarnicaoCabo.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoComandante.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tg_app/view/cadastroGuarnicaoSentinela1.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoSentinela2.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoSentinela3.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoSentinela4.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoSentinela5.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoSentinela6.view.dart';

class CadastroGuarnicao extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String>? lista = ["Teste", "Matheus", "Matheus"];

  CadastroGuarnicao({Key? key, this.lista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: firestore.collection('atiradores').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return const Text('Erro ao carregar dados');
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        // print(snapshot.data!.docs[0].get(''));

        return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (_, index) {
              return Container();
              // return Text(snapshot.data!.docs[index].data()[0]);
            });
        /*
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CadastroGuarnicaoItem(
                lista: ["lista", "Matheus"],
              ),
            ],
          );*/ //Text(snapshot.data!.data()!['id']);
      },
      /*Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        
        CadastroGuarnicaoComandante(
          lista: ["lista", "Matheus"],
        ),
        CadastroGuarnicaoCabo(
          lista: ["Padilha", "Matheus"],
        ),
        CadastroGuarnicaoSentinela1(
          lista: ["Padilha", "Matheus"],
        ),
        CadastroGuarnicaoSentinela2(
          lista: ["Padilha", "Matheus"],
        ),
        CadastroGuarnicaoSentinela3(
          lista: ["Padilha", "Matheus"],
        ),
        CadastroGuarnicaoSentinela4(
          lista: ["Padilha", "Matheus"],
        ),
        CadastroGuarnicaoSentinela5(
          lista: ["Padilha", "Matheus"],
        ),
        CadastroGuarnicaoSentinela6(
          lista: ["Padilha", "Matheus"],
        ),
      ],
    )*/
      /* 

        // separatorBuilder: (_,i) => Divider(),
        //  itemCount: mensagens.length,
        //  itemBuilder: (_, index) =>  MensagemItem(mensagens[index])
        //mensagens.map((m) => MensagemItem(m)).toList()
      ),*/
    ));
  }
}
