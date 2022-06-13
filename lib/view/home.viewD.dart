import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final value = true;
  String nome = '';
  String email = '';
  String userType = '';

  Future carregaUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser!;

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var usuario = await firestore.collection('atiradores').doc(user.uid).get();
    if (usuario.exists) {
      userType = 'atirador';
      nome = usuario['nome'] ?? '';
      print('usuario Atirador');
    } else {
      var usuario =
          await firestore.collection('instrutores').doc(user.uid).get();
      if (usuario.exists) {
        userType = 'instrutor';
        nome = usuario['nome'] ?? '';
        print('usuario Instrutor');
      }
    }
    email = user.email.toString();

    setState(() {});

    return user;
  }

  void logout() async {
    FirebaseAuth user = FirebaseAuth.instance;
    await user.signOut();

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
                  "A",
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
                  _closeDrawer(context);
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
                      Text('Home',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: 'Montserrat-S',
                          )),
                      IconButton(
                        icon: Icon((Icons.person)),
                        iconSize: 30,
                        color: Colors.white,
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
                    userType == 'instrutor'
                        ? Container(
                            margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, "/chamadaPelotao");
                                              },
                                              iconSize: 50,
                                              icon: Icon(Icons.group)),
                                          Text('Chamada')
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/calendario');
                                              },
                                              iconSize: 50,
                                              icon: Icon(Icons.table_view)),
                                          Text('Guarnição')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        : Container(),
                    userType == 'instrutor'
                        ? Container(
                            margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    '/cadastroAtirador');
                                              },
                                              iconSize: 50,
                                              icon: Icon(Icons.person_add)),
                                          Text('Cadastrar Atirador')
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    '/cadastroInstrutor');
                                              },
                                              iconSize: 50,
                                              icon: Icon(
                                                  Icons.supervisor_account)),
                                          Text('Cadastrar Instrutor')
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        : Container(),
                    Container(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/calendarioVizu");
                                          },
                                          iconSize: 50,
                                          icon: Icon(Icons.group)),
                                      Text('Ver guarnição')
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/chamadaPelotaoV');
                                          },
                                          iconSize: 50,
                                          icon: Icon(Icons.table_view)),
                                      Text('Ver chamada')
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
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
    //validar se o usuário está logado
    /* if (user == null) {
      Navigator.pushNamed(context, '/login');
    }*/
  }
}
