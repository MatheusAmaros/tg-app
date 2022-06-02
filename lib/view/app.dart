import 'package:flutter/material.dart';
import 'package:tg_app/view/cadastroAtirador.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoCompleta.view.dart';
import 'package:tg_app/view/cadastroInstrutor.view.dart';
import 'package:tg_app/view/chamada.view.dart';
import 'package:tg_app/view/chamadaPelotao.view.dart';
import 'package:tg_app/view/chamadaVisualizar.view.dart';
import 'package:tg_app/view/login.view.dart';
import 'package:tg_app/view/home.view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chamadaPelotaoVisualizar.view.dart';

class App extends StatelessWidget {

FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: auth.currentUser == null ? '/login':'/home',
      routes: {
        '/login': (context) => LoginWidget(),
        '/chamadaPelotao': (context) => ChamadaPelotaoView(),
        '/chamadaPelotaoV': (context) => ChamadaPelotaoVisualizarView(),
        '/chamadaV': (context) => ChamadaVizualizarView(),
        '/chamada': (context) => ChamadaView(),
        '/cadastroAtirador': (context) => CadastroAtirador(),
        '/cadastroInstrutor': (context) => CadastroInstrutor(),
        '/home':(context) => Home()
      },
    );
  }
}
