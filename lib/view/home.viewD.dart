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
  String nome ='';
  String email ='';

  Future carregaUsuario () async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user =  auth.currentUser!;  

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var usuario = await firestore.collection('atiradores').doc(user.uid).get();
    nome = usuario['nome'];
    email = user.email.toString();
    print(nome);
    print(email);
    setState(() {
      
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
        currentAccountPicture: CircleAvatar(  
                backgroundColor: Colors.orange,  
                child: Text(  
                  "A",  
                  style: TextStyle(fontSize: 40.0),  
                ),  
              ),  
      accountName: Text(nome),
      accountEmail: Text(email),
       ),
      ListTile(
           leading: Icon(Icons.account_circle, color: Colors.black,size: 35,),
            title: Text("Perfil",style: TextStyle(fontFamily:'Times New Roman',fontSize: 16),),
            onTap: () {
              setState(() {
                  Navigator.pop(context);
              });
            },
          
      ),
      ListTile(
        title: const Text('Item 2'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            //repeat: ImageRepeat.repeat,
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
                                                context, "/chamada");
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/guarnicao');
                                          },
                                          iconSize: 50,
                                          icon: Icon(Icons.table_view)),
                                      Text('Guarnição')
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    Container(
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
                                              context, '/cadastroAtirador');
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/cadastroInstrutor');
                                        },
                                        iconSize: 50,
                                        icon: Icon(Icons.supervisor_account)),
                                    Text('Cadastrar Instrutor')
                                  ],
                                ),
                              ],
                            ),
                          ]),
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
    carregaUsuario();
  }
}
