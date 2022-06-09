import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChamadaPelotaoVisualizarView extends StatefulWidget {
  @override
  State<ChamadaPelotaoVisualizarView> createState() => _chamadaPelotaoVisualizarViewState();
}

class _chamadaPelotaoVisualizarViewState extends State<ChamadaPelotaoVisualizarView> {

  List<DropdownMenuItem<String>> get dropdownItemsPelotao {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Pelotão 1",  style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat',)), value: "1"),
      DropdownMenuItem(child: Text("Pelotão 2",  style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat',)), value: "2"),
      DropdownMenuItem(child: Text("Pelotão 3",  style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat',)), value: "3"),
      DropdownMenuItem(child: Text("Pelotão 4",  style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat',)), value: "4"),
    ];
    return menuItems;
  }

  String pelotao = '1';
  String dataInicial = DateTime.now().toString();
  String dataText = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();

    Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 34, 2),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.dstATop),
            image: Image.asset('assets/images/camuflagem2.jpg',).image,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
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
                      Text('Chamada', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Montserrat-S',)),
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
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selecione a data', 
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontFamily: 'Montserrat-S',
                            )
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            title: Text(dataText), 
                            trailing: Icon(Icons.calendar_month_outlined, color: Colors.grey.shade900), 
                            onTap: () async {
                              DateTime? datePicker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(dataInicial),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                builder: (context, child) => Theme(
                                  data: ThemeData().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Color.fromARGB(255, 0, 34, 2),
                                      onPrimary: Colors.white,
                                    )
                                  ), 
                                  child: child!)
                              );
                              if(datePicker != null){
                                setState(() {
                                  dataInicial = DateFormat("yyyy-MM-dd").format(datePicker).toString();
                                  dataText = DateFormat("dd/MM/yyyy").format(datePicker).toString();
                                });
                              }
                            }
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selecione o pelotao', 
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontFamily: 'Montserrat-S',
                            )
                          ),
                          DropdownButton(
                            isExpanded: true,
                            items: dropdownItemsPelotao,
                            value: pelotao,
                            onChanged: (String? value) {
                              setState(() {
                                pelotao = value!;
                              });
                            },
                            underline: Container(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: [ 
                          ElevatedButton(
                            child: Text("Visualizar", style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat',)),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 0, 34, 2),
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            ),
                            onPressed:() {
                              Navigator.of(context).pushNamed('/chamadaV', arguments: {'pelotao': pelotao, 'dataText': dataText, 'dataInv': dataInicial});
                            },
                          ),
                          ElevatedButton(
                            child: Text("Cadastrar", style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat',)),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 0, 34, 2),
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            ),
                            onPressed:() {
                              Navigator.of(context).pushNamed('/chamadaPelotao');
                            },
                          )
                        ]
                      )
                    ),
                  ]
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}