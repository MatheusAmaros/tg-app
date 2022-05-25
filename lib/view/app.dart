import 'package:flutter/material.dart';
import 'package:tg_app/view/cadastro.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoCompleta.view.dart';
import 'package:tg_app/view/chamada.view.dart';
import 'package:tg_app/view/chamadaPelotao.view.dart';
import 'package:tg_app/view/login.view.dart';
import 'package:tg_app/view/home.view.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        '/chamada': (context) => ChamadaView(),
        '/cadastro': (context) => CadastroAtirador(),
        '/home':(context) => Home()
      },
    );
  }
}
