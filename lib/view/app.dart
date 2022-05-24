import 'package:flutter/material.dart';
import 'package:tg_app/view/cadastro.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoCompleta.view.dart';
import 'package:tg_app/view/chamada.view.dart';
import 'package:tg_app/view/chamadaPelotao.view.dart';
import 'package:tg_app/view/login.view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/chamadaPelotao',
      routes: {
        '/login': (context) => LoginWidget(),
        '/chamadaPelotao': (context) => ChamadaPelotaoView(),
        '/chamada': (context) => ChamadaView(),
        '/cadastro': (context) => CadastroAtirador()

      },
    );
  }
}
