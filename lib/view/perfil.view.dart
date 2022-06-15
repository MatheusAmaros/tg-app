import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class Perfil extends StatefulWidget {
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final value = true;
  String nome = '';
  String email = '';
  String cpf = '';
  String numero = '';
  String telefone = '';
  String anoIngresso = '';
  String userType = '';
  String pelotao = '';
  String funcao = '';
  var userUid = '';

  Future carregaUsuario() async {
    if (await SessionManager().containsKey('userUid')) {
      userUid = await SessionManager().get('userUid');
    } else {
      FirebaseAuth auth = FirebaseAuth.instance;
      var user = auth.currentUser!;
      userUid = user.uid;
    }
    //print(userUid);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var usuario = await firestore.collection('atiradores').doc(userUid).get();
    if (usuario.exists) {
      userType = 'atirador';
      pelotao = usuario['pelotao'];
      anoIngresso = usuario['anoIngresso'];
      numero = usuario['numero'];
      funcao = usuario['funcao'];
    } else {
      usuario = await firestore.collection('instrutores').doc(userUid).get();
      if (usuario.exists) {
        userType = 'instrutor';
      }
    }

    nome = usuario['nome'];
    email = usuario['email'];
    cpf = usuario['cpf'];
    telefone = usuario['telefone'];

    setState(() {});

    return userUid;
  }

  void logout() async {
    FirebaseAuth user = FirebaseAuth.instance;
    await user.signOut();

    await SessionManager().remove('userUid');

    SessionManager().destroy;

    setState(() {
      Navigator.popAndPushNamed(context, '/login');
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 6, 39, 17)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 109, 173, 236),
                child: Text(
                  nome.length > 2 ? nome.substring(0, 2) : 'A',
                  style: TextStyle(
                      fontSize: 40.0, color: Color.fromARGB(255, 15, 15, 84)),
                ),
              ),
              accountName: Text(nome),
              accountEmail: Text(email),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Text(
                "Perfil",
                style: TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  // Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.house,
                color: Colors.black,
                size: 35,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  Navigator.popAndPushNamed(context, '/home');
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
                size: 35,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  logout();
                });
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 0, 34, 2),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25), BlendMode.dstATop),
            image: Image.asset(
              'assets/images/camuflagem2.jpg',
            ).image,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: _openDrawer,
                      ),
                      Text('Perfil',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: 'Montserrat-S',
                          )),
                      IconButton(
                        icon: Icon((Icons.person)),
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
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: CircleAvatar(
                              maxRadius: 40,
                              backgroundColor:
                                  Color.fromARGB(255, 109, 173, 236),
                              child: Text(
                                nome.length > 2 ? nome.substring(0, 2) : 'A',
                                style: TextStyle(
                                    fontSize: 40.0,
                                    color: Color.fromARGB(255, 15, 15, 84)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 10, 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 100, 10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 239, 238, 238),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nome: ' + nome,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 100, 10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 239, 238, 238),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Email: ' + email,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 100, 10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 239, 238, 238),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Telefone: ' + telefone,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 100, 10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 239, 238, 238),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'CPF: ' + cpf,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              userType == 'atirador'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 100, 10),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 239, 238, 238),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Número: ' + numero,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              userType == 'atirador'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 100, 10),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 239, 238, 238),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Ano Ingresso: ' +
                                                      anoIngresso,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              userType == 'atirador'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 100, 10),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 239, 238, 238),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Função: ' + funcao,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              userType == 'atirador'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 100, 10),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 239, 238, 238),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pelotão: ' + pelotao,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    super.initState();

    final user = carregaUsuario();
  }
}
