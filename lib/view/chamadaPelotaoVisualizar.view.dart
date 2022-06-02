import 'package:flutter/material.dart';

class ChamadaPelotaoVisualizarView extends StatefulWidget {
  @override
  State<ChamadaPelotaoVisualizarView> createState() => _chamadaPelotaoVisualizarViewState();
}

class _chamadaPelotaoVisualizarViewState extends State<ChamadaPelotaoVisualizarView> {

  List<DropdownMenuItem<String>> get dropdownItemsPelotao {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Pelotão 1"), value: "pelotao1"),
      DropdownMenuItem(child: Text("Pelotão 2"), value: "pelotao2"),
      DropdownMenuItem(child: Text("Pelotão 3"), value: "pelotao3"),
      DropdownMenuItem(child: Text("Pelotão 4"), value: "pelotao4"),
    ];
    return menuItems;
  }

  String pelotao = 'pelotao1';

    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 8, 56, 11),
          automaticallyImplyLeading: true,
          title: Text(
            'Visualizar chamada',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selecione a data', 
                      style: TextStyle(
                        color: Colors.white,
                      )
                    ),
                    ListTile(
                      title: Text(pelotao, style: TextStyle(color: Colors.white)), 
                      trailing: Icon(Icons.calendar_month_outlined, color: Colors.white), 
                      onTap: () {
                        print("clicou!");
                      },
                    ),
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selecione o pelotao', 
                      style: TextStyle(
                        color: Colors.white,
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
                      style: TextStyle(color: Colors.white),
                      dropdownColor: Colors.black,
                      underline: Container(),
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      );
    }

}