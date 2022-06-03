import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String dataInicial = DateTime.now().toString();
  String dataText = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();

    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
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
                margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selecione a data', 
                      style: TextStyle(
                        color: Colors.black,
                      )
                    ),
                    ListTile(
                      title: Text(dataText), 
                      trailing: Icon(Icons.calendar_month_outlined, color: Colors.black), 
                      onTap: () async {
                        DateTime? datePicker = await showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(dataInicial),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                          //#222118
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Colors.grey.shade800,
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
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selecione o pelotao', 
                      style: TextStyle(
                        color: Colors.black,
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
            ]
          )
        )
      );
    }

}