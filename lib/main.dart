import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tg_app/view/app.dart';

void main() async {




  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /*FirebaseFirestore db = FirebaseFirestore.instance;
db.collection("atiradores").doc('pelotao1').set({
'nome':'Andre',
'cpf':'1111111111',
'numero':'02',
'Telefone':'17992061685',
'Email':'andre@email.com',
'Função': 'sentinela',
'Graduação' :'atirador'

});*/


  runApp(App());
}
