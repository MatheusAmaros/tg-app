import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tg_app/model/atiradorEdicao.model.dart';
import 'package:tg_app/view/teste.view.dart';

import 'alteracaoAtirador.viewD.dart';

class BuscarUsuario extends StatefulWidget {
  @override
  State<BuscarUsuario> createState() => _BuscarUsuarioState();
}

class _BuscarUsuarioState extends State<BuscarUsuario> {
  final firestore = FirebaseFirestore.instance;
  final filtroInstrutorCtrl = TextEditingController();
  final filtroAtiradorCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
        length: 2,
        child: Scaffold(
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
                            icon: Icon(Icons.arrow_back_ios_rounded),
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text('Alteração',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontFamily: 'Montserrat-S',
                              )),
                          IconButton(
                            icon: Icon((Icons.perm_identity_sharp)),
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  child: const TabBar(
                    tabs: [Tab(text: "Instrutor"), Tab(text: "Atirador")],
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.green,
                    labelStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 17),
                    indicatorColor: Colors.transparent
                  )
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
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
                          child: TabBarView(children: [
                            Column(children: [
                              TextField(
                                controller: filtroInstrutorCtrl,
                                decoration: const InputDecoration(
                                    labelText: 'Search',
                                    suffixIcon: Icon(Icons.search)),
                                onChanged: (value){
                                  setState(() {
                                    
                                  });
                                },
                              ),
                              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: firestore.collection('instrutores').orderBy('nome').startAt([filtroInstrutorCtrl.text]).snapshots(),
                                builder: (_, snapshot){
                                  if (!snapshot.hasData) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Text("Erro");
                                  }
                                  if(snapshot.data!.docs.length == 0){
                                    return Center(child: Text("Sem instrutores cadastrados"));
                                  }
                                  return Flexible(
                                    child: ListView.builder(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (_, index) {
                                        return ListTile(
                                          title: Text("Nome: " + snapshot.data!.docs[index]['nome']),
                                          leading: Icon(Icons.person),
                                          trailing: IconButton(icon: Icon(Icons.edit),
                                          onPressed: (){},),
                                          selectedTileColor: Colors.green[400],
                                          onTap: () {
                                            Navigator.of(context).pushNamed('/alterarInstrutor', arguments: {'uid': snapshot.data!.docs[index]['uid']});
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }
                              ),
                            ]),
                            Column(children: [
                              TextField(
                                controller: filtroAtiradorCtrl,
                                decoration: const InputDecoration(
                                    labelText: 'Search',
                                    suffixIcon: Icon(Icons.search)),
                                onChanged: (value){
                                  setState(() {
                                    
                                  });
                                },
                              ),
                              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                stream: firestore.collection('atiradores').orderBy('nome').startAt([filtroAtiradorCtrl.text]).snapshots(),
                                builder: (_, snapshot){
                                  if (!snapshot.hasData) {
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Text("Erro");
                                  }
                                  if(snapshot.data!.docs.length == 0){
                                    return Center(child: Text("Sem atiradores cadastrados"));
                                  }
                                  return Flexible(
                                    child: ListView.builder(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (_, index) {
                                        return ListTile(
                                          title: Text("Nome: " + snapshot.data!.docs[index]['nome']),
                                          leading: Icon(Icons.person),
                                          trailing: IconButton(icon: Icon(Icons.edit),
                                          onPressed: (){},),
                                          selectedTileColor: Colors.green[400],
                                          onTap: () {
                                            Navigator.of(context).pushNamed('/alterarAtirador', arguments: {'uid': snapshot.data!.docs[index]['uid']});
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }
                              ),
                            ]),
                          ]),
                        ),
                      ),
                ),
              ],
            ),
          ),
        )
        );
  }
}
