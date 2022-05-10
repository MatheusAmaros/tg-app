import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class CadastroAtirador extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  String nome = '';
  String cpf = '';
  String numero = '';
  String telefone = '';
  String email = '';
  String pelotao = 'pelotao_2';
  String anoIngresso = '2022';
  String funcao = '';
  String graduacao = '';
  String senha = '';
  String _chosenValue = '';

  List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("Canada"),value: "Canada"),
    DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];
  return menuItems;
  }



/*
Não aparece na tela: 
Última guarda preta (dias uteis)
Última guarda vermelha (dias não uteis)*/

  void cadastrarUsuario(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

      
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

   
       var result = await auth.createUserWithEmailAndPassword(email: email, password: senha);
      
      //await result.user!.updateDisplayName(nome);

       db.collection("Atiradores")
          .doc(pelotao)
          .collection(anoIngresso)
          .doc()
          .set({
        'nome': nome,
        'cpf': cpf,
        'numero': numero,
        'Telefone': telefone,
        'Email': email,
        'Função': funcao,
        'Graduação': graduacao
      });

      print('salvo');
    }
  }

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
                        onSaved: (value) => nome = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo Nome é obrigatório";
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
                        onSaved: (value) => cpf = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo CPF obrigatório";
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
                        onSaved: (value) => numero = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo Numero obrigatório";
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
                        onSaved: (value) => telefone = value!,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Campo Telefone obrigatório";
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
                        onSaved: (value) => email = value!,
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
                        onSaved: (value) => pelotao = value!,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Campo Pelotao obrigatório";
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
                        onSaved: (value) => anoIngresso = value!,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Campo Ano de Ingreso é obrigatório";
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
                        onSaved: (value) => funcao = value!,
                        validator: (value) {
                          if (value!.isEmpty) return "Campo Função obrigatório";
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
                        onSaved: (value) => graduacao = value!,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Campo Graduação obrigatório";
                          return null;
                        },
                      ),
                    ),
                                        Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Senha",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            labelText: "Senha",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            prefixIcon: Icon(Icons.password)),
                        onSaved: (value) => senha = value!,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Campo Senha obrigatório";
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: DropdownButton(items: dropdownItems, onChanged: (String? value) {  },),
                    ),
                    
                    ElevatedButton(
                      onPressed: () {
                        cadastrarUsuario(context);
                      },
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
