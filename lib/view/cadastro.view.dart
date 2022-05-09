import 'package:flutter/material.dart';

class CadastroAtirador extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  /* 
  Nome
CPF
Número do atirador
Telefone
Email
Pelotão
Ano de ingresso (atual)
Função 
Graduação 
Não aparece na tela: 
Última guarda preta (dias uteis)
Última guarda vermelha (dias não uteis)*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/f9dhs_4.jpg',
            ).image,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  spreadRadius: 15,
                  blurRadius: 50,
                  offset: Offset(2, 7), // changes position of shadow
                ),
              ],
            ),
            width: 380,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: ListView(
                  //aqui
                  //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //  mainAxisSize: MainAxisSize.min,
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "CADASTRAR ATIRADOR",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.account_circle_outlined,
                            size: 40, color: Color.fromARGB(255, 0, 0, 0))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Nome",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Nome",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.person)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "CPF",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "CPF",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.house)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Numero do Atirador",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Numero do Atirador",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.numbers)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Telefone",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Telefone",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.phone)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "E-mail Address",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "E-mail",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.email)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Pelotão",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Pelotão",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.people)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Ano de Ingresso",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Ano de Ingresso",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.calendar_month)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Função",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Função",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.people)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Graduação",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Graduação",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.people)),
                        onSaved: (value) => () {}, //email = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo E-mail obrigatório";
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Cadastrar"),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xFF757575),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
