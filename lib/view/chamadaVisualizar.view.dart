import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChamadaVizualizarView extends StatefulWidget {
  ChamadaVizualizarView({Key? key}) : super(key: key);

  @override
  State<ChamadaVizualizarView> createState() => _ChamadaVizualizarViewState();
}

class _ChamadaVizualizarViewState extends State<ChamadaVizualizarView> {
  final firestore = FirebaseFirestore.instance;

  bool presenca = false;
  String anoIngresso = DateTime.now().year.toString();
  bool value1 = true;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final numPelotao = arguments['pelotao'];
    final pelotaoBusca = 'pelotao$numPelotao';
    final dataInv = DateFormat("yyyy-MM-dd")
        .format(DateTime.parse(arguments['dataInv']))
        .toString();
    final dataText = arguments['dataText'];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 34, 2),
      body: SafeArea(
        child: Container(
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
                        Text('Chamada',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontFamily: 'Montserrat-S',
                            )),
                        IconButton(
                          icon: Icon((Icons.perm_identity_sharp)),
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
                  child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.grey.shade900,
                      ),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: firestore
                            .collection('chamadas')
                            .doc(dataInv)
                            .collection(pelotaoBusca)
                            .snapshots(),
                        builder: (_, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Text("Erro");
                          }
                          if (snapshot.data!.docs.length == 0) {
                            return Center(
                                child: Text(
                              "Sem chamada cadastrada.",
                              style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontFamily: 'Montserrat',
                                  fontSize: 17),
                            ));
                          }

                          return Column(children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                            ),
                            Text(
                              "Pelotão $numPelotao - $dataText",
                              style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontFamily: 'Montserrat-S',
                                  fontSize: 15),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                return CheckboxListTile(
                                  title:
                                      Text(snapshot.data!.docs[index]['nome'],
                                          style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontFamily: 'Montserrat',
                                          )),
                                  value: snapshot.data!.docs[index]['presenca'],
                                  activeColor: Color.fromARGB(255, 8, 56, 11),
                                  onChanged: (value) {},
                                );
                              },
                            ),
                          ]);
                        },
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
