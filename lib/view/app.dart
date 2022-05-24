import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tg_app/view/cadastro.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoCompleta.view.dart';
import 'package:tg_app/view/chamada.view.dart';
import 'package:tg_app/view/login.view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/cadastroGuarnicao',
      routes: {
        '/login': (context) => LoginWidget(),
        '/chamada': (context) => Chamada(),
        '/cadastro': (context) => CadastroAtirador(),
        '/cadastroGuarnicao': (context) => CadastroGuarnicaoCompleta()
      },
    );
  }
}
