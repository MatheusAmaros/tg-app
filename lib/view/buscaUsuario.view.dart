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
  final value = true;
  List<AtiradorModel> atiradores = allAtiradores;

  void searchAtiradores(String query)
  {
    final suggestions = allAtiradores.where((atirador) {
      final nome = atirador.nome.toString().toLowerCase();
      final input = query.toLowerCase();

      return nome.contains(input);
    } ).toList();

  setState(() {
    atiradores =suggestions;
  });
  }
/*
  void listarIntrutores() {
    firestore.collection('intrutores').where('pelotao', isEqualTo: pelotaoBusca).get()
    .then((val){
      for (var element in val.docs) {
         firestore
          .collection("chamadas")
          .doc(dataInv)
          .collection(pelotaoBusca)
          .doc(element.data()["uid"])
          .set({
            'uid': element.data()["uid"],
            'nome': element.data()["nome"],
            'presenca': false
          });
      }  
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                        labelStyle:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 17),
                        indicatorColor: Colors.transparent)),
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
                              //onChanged: (value) => _runFilter(value),
                              decoration: const InputDecoration(
                                  labelText: 'Search',
                                  suffixIcon: Icon(Icons.search)),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (_, index) {
                                return Center(child: Text("Instrutor"));
                              },
                            ),
                          ]),
                          Column(children: [
                            TextField(
                              //onChanged: (value) => _runFilter(value),
                              onChanged: searchAtiradores,
                              decoration: const InputDecoration(
                                  labelText: 'Search',
                                  suffixIcon: Icon(Icons.search)),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              shrinkWrap: true,
                              itemCount: atiradores.length,
                              itemBuilder: (context, index) {
                                final AtiradorModel = atiradores[index];

                                return ListTile(
                                  title: Text("Atirador: "+AtiradorModel.nome),
                                  subtitle: Text("Numero: "+AtiradorModel.numero),
                                  leading: Icon(Icons.person),
                                  trailing: IconButton(icon: Icon(Icons.edit),
                                  onPressed: (){},),
                                  selectedTileColor: Colors.green[400],
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> atiradorEdit(atirador: AtiradorModel,)));
                                  },
                                );
                              },
                            ),
                          ]),
                        ]),
                      )),
                ),
              ],
            ),
          ),
        ));

        
  }
}
