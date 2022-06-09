import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tg_app/view/cadastroAtirador.viewD.dart';
//import 'package:tg_app/view/cadastroGuarnicaoCompleta.view.dart';
import 'package:tg_app/view/cadastroInstrutor.view.dart';
import 'package:tg_app/view/calendar.view.dart';
import 'package:tg_app/view/calendarVisualizacao.view.dart';
import 'package:tg_app/view/chamada.view.dart';
import 'package:tg_app/view/chamadaPelotao.view.dart';
import 'package:tg_app/view/chamadaVisualizar.view.dart';
import 'package:tg_app/view/design.view.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tg_app/view/home.viewD.dart';
import 'package:tg_app/view/login.viewD.dart';

import 'chamadaPelotaoVisualizar.view.dart';

class App extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],

      initialRoute: auth.currentUser == null ? '/login':'/home',
      routes: {
        '/login': (context) => Login(),
        '/chamadaPelotao': (context) => ChamadaPelotaoView(),
        '/chamadaPelotaoV': (context) => ChamadaPelotaoVisualizarView(),
        '/chamada': (context) => ChamadaView(),
        '/cadastroAtirador': (context) => CadastroAtirador(),
        '/cadastroInstrutor': (context) => CadastroInstrutor(),
        '/home': (context) => Home(),
        '/des': (context) => Design(),
        '/calendario': (context) => CalendarPage(),
        '/calendarioVizu': (context) => CalendarPageView(),
        '/vizualizarGuarnicao': (context) => CalendarPage(),
      },
    );
  }
}
