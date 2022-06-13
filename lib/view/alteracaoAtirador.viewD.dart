import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tg_app/model/atiradorEdicao.model.dart';

class EditarAtirador extends StatefulWidget {
  final AtiradorModel atirador;

  const EditarAtirador({Key? key, required this.atirador}) : super(key: key);

  @override
  State<EditarAtirador> createState() => _EditarAtiradorState();
}

class _EditarAtiradorState extends State<EditarAtirador> {
  var formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final nomeController = TextEditingController();

  final cpfController = TextEditingController();

  final numeroController = TextEditingController();

  final telefoneController = TextEditingController();

  final emailController = TextEditingController();

  final senhaController = TextEditingController();

  final funcaoController = TextEditingController();

  final pelotaoController = TextEditingController();

  String nome = '';
  String email = '';
  String userType = '';
  var userUid = '';
  bool passwordVisibility = true;

  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

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

  /*List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Pelotão 1"), value: "pelotao1"),
      DropdownMenuItem(child: Text("Pelotão 2"), value: "pelotao2"),
      DropdownMenuItem(child: Text("Pelotão 3"), value: "pelotao3"),
      DropdownMenuItem(child: Text("Pelotão 4"), value: "pelotao4"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get funcaoItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Comandante"), value: "comandante"),
      DropdownMenuItem(child: Text("Cabo"), value: "cabo"),
      DropdownMenuItem(child: Text("Sentinela"), value: "sentinela"),
    ];
    return menuItems;
  }*/

  _EditarAtiradorState() {
    
   nomeController.text = widget.atirador.nome.toString();
    /*cpfController.text = widget.atirador.nome!;
    numeroController.text = widget.atirador.nome!;
    telefoneController.text = widget.atirador.nome!;
    emailController.text = widget.atirador.nome!;
    funcaoController.text = widget.atirador.nome!;
    pelotaoController.text = widget.atirador.nome!;*/
  }

  void logout() async {
    FirebaseAuth user = FirebaseAuth.instance;
    await user.signOut();

    await SessionManager().remove('userUid');

    setState(() {
      Navigator.popAndPushNamed(context, '/login');
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey ,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 6, 39, 17)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 109, 173, 236),
                child: Text(
                  // widget.atirador.nome!,
                  'A',
                  style: TextStyle(
                      fontSize: 40.0, color: Color.fromARGB(255, 15, 15, 84)),
                ),
              ),
              accountName: Text(nome),
              accountEmail: Text(email),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Text(
                "Perfil",
                style: TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  // Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.house,
                color: Colors.black,
                size: 35,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  Navigator.popAndPushNamed(context, '/home');
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
                size: 35,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontFamily: 'Times New Roman', fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  logout();
                });
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
                      Text('',
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
                child: Container(
                    child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                            child: Text(
                              'Alterar Registro',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                            child: TextFormField(
                              maxLength: 50,
                              //obscureText: passwordVisibility,
                              controller: nomeController,
                              style: TextStyle(fontFamily: 'Montserrat-S'),
                              decoration: InputDecoration(
                                labelText: 'Nome:',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat-S',
                                  color: Color.fromARGB(255, 165, 165, 165),
                                ),
                              ),
                              onSaved: (value) => nomeController.text = value!,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Campo Nome é obrigatório";

                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: TextFormField(
                              inputFormatters: [cpfMask],
                              controller: cpfController,
                              style: TextStyle(fontFamily: 'Montserrat-S'),
                              decoration: InputDecoration(
                                labelText: 'CPF:',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat-S',
                                  color: Color.fromARGB(255, 165, 165, 165),
                                ),
                              ),
                              onSaved: (value) => cpfController.text = value!,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Campo CPF obrigatório";

                                if (value.length < 14)
                                  return "Preencha seu CPF";

                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                            child: TextFormField(
                              maxLength: 80,
                              controller: emailController,
                              style: TextStyle(fontFamily: 'Montserrat-S'),
                              decoration: InputDecoration(
                                labelText: 'E-mail:',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat-S',
                                  color: Color.fromARGB(255, 165, 165, 165),
                                ),
                              ),
                              onSaved: (value) => emailController.text = value!,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Campo E-mail obrigatório";

                                if (!emailValid.hasMatch(value))
                                  return "Formato de email inserido está incorreto";

                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: TextFormField(
                              inputFormatters: [telephoneMask],
                              controller: telefoneController,
                              style: TextStyle(fontFamily: 'Montserrat-S'),
                              decoration: InputDecoration(
                                labelText: 'Telefone:',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat-S',
                                  color: Color.fromARGB(255, 165, 165, 165),
                                ),
                              ),
                              onSaved: (value) =>
                                  telefoneController.text = value!,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Campo Telefone obrigatório";

                                if (value.length < 15)
                                  return "Preencha seu Telefone";

                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                            child: TextFormField(
                              maxLength: 30,
                              obscureText: passwordVisibility,
                              controller: senhaController,
                              style: TextStyle(fontFamily: 'Montserrat-S'),
                              decoration: InputDecoration(
                                  labelText: 'Senha:',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat-S',
                                    color: Color.fromARGB(255, 165, 165, 165),
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordVisibility
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          passwordVisibility =
                                              !passwordVisibility;
                                        });
                                      })),
                              onSaved: (value) => senhaController.text = value!,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Campo Senha obrigatório";

                                if (value.length < 6)
                                  return "Sua senha deve ter no mínimo 6 caracteres";
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: TextFormField(
                              inputFormatters: [numberMask],
                              controller: numeroController,
                              style: TextStyle(fontFamily: 'Montserrat-S'),
                              decoration: InputDecoration(
                                labelText: 'Número do atirador:',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat-S',
                                  color: Color.fromARGB(255, 165, 165, 165),
                                ),
                              ),
                              onSaved: (value) =>
                                  numeroController.text = value!,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Campo Numero obrigatório";
                                return null;
                              },
                            ),
                          ),
                         /* Container(
                            margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pelotão:',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-S',
                                    color: Color.fromARGB(255, 165, 165, 165),
                                  ),
                                ),
                                DropdownButton(
                                  isExpanded: true,
                                  items: dropdownItems,
                                  value: 'pelotao2',
                                  onChanged: (String? value) {
                                    setState(() {
                                      pelotaoController.text = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 30, 15, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Função:',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-S',
                                    color: Color.fromARGB(255, 165, 165, 165),
                                  ),
                                ),
                                DropdownButton(
                                  isExpanded: true,
                                  items: funcaoItems,
                                  value: 'sentinela',
                                  onChanged: (String? value) {
                                    setState(() {
                                      funcaoController.text = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),*/
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Cadastrar"),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 0, 34, 2),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 130, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ]),
                  ]),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

@override
  initState() {
  super.initState();
 // Add listeners to this class
}
}
