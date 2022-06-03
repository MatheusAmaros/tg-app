import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CadastroInstrutor extends StatefulWidget {
  @override
  State<CadastroInstrutor> createState() => _CadastroInstrutorState();
}

class _CadastroInstrutorState extends State<CadastroInstrutor> {
  var formKey = GlobalKey<FormState>();

  String nome = '';

  String cpf = '';

  String telefone = '';

  String email = '';
  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String senha = '';


  var telephoneMask = new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

  var cpfMask = new MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

  var numberMask = new MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.eager);

/*
Não aparece na tela: 
Última guarda preta (dias uteis)
Última guarda vermelha (dias não uteis)*/
  void cadastrarUsuario(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;


    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: senha);

      db
          .collection("instrutores")
          .doc(result.user!.uid)
          .set({
        'nome': nome,
        'cpf': cpf,
        'telefone': telefone,
        'email': email,
        'uid':result.user!.uid
      });

      setState(() {
         nome = '';
         cpf = '';
         telefone = '';
         email = '';
         senha = '';

      Fluttertoast.showToast(
        msg: "Instrutor cadastrado com sucesso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        webPosition:'center',

    );

      });
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "CADASTRAR INSTRUTOR",
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
                        inputFormatters: [cpfMask],
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

                          if (value.length < 14) return "Preencha seu CPF";

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

                          if (!emailValid.hasMatch(value))
                            return "Formato de email inserido está incorreto";

                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 12, 12, 12),
                      child: TextFormField(
                        inputFormatters: [telephoneMask],
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

                          if (value.length < 15) return "Preencha seu Telefone";

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
                          if (value!.isEmpty) return "Campo Senha obrigatório";

                          if (value.length < 6)
                            return "Sua senha deve ter no mínimo 6 caracteres";
                          return null;
                        },
                      ),
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