import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tg_app/view/login.viewD.dart';

class CadastroAtirador extends StatefulWidget {
  @override
  State<CadastroAtirador> createState() => _CadastroAtiradorState();
}

class _CadastroAtiradorState extends State<CadastroAtirador> {
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

  List<DropdownMenuItem<String>> get dropdownItems {
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
  }

  Future carregaUsuario() async {

    if(await SessionManager().containsKey('userUid'))
    {
       userUid = await SessionManager().get('userUid');
    }
    else{
          FirebaseAuth auth = FirebaseAuth.instance;
          var user = auth.currentUser!;
           userUid = user.uid;
    }
    //print(userUid);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

     var usuario = await firestore.collection('atiradores').doc(userUid).get();
    if (usuario.exists) {
      userType = 'atirador';
    } 
    else {
       usuario = await firestore.collection('instrutores').doc(userUid).get();
      if (usuario.exists) {
        userType = 'instrutor';
      }
    }

    nome = usuario['nome'];
    email = usuario['email'];

    setState(() {});

    return userUid;
  }

  _CadastroAtiradorState() {
    funcaoController.text = 'sentinela';
    pelotaoController.text = 'pelotao1';
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

  void cadastrarUsuario(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var anoIngresso = DateTime.now().year.toString();

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      var result = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: senhaController.text);

      //await result.user!.updateDisplayName(nome);

      db.collection("atiradores").doc(result.user!.uid).set({
        'nome': nomeController.text,
        'cpf': cpfController.text,
        'numero': numeroController.text,
        'telefone': telefoneController.text,
        'email': emailController.text,
        'funcao': funcaoController.text,
        'pelotao': pelotaoController.text,
        'anoIngresso': anoIngresso,
        'uid': result.user!.uid
      });

      nomeController.clear();
      cpfController.clear();
      numeroController.clear();
      telefoneController.clear();
      emailController.clear();
      senhaController.clear();
      funcaoController.text = 'sentinela';
      pelotaoController.text = 'pelotao1';

      setState(() {
        Fluttertoast.showToast(
          msg: "Atirador cadastrado com sucesso!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          webPosition: 'center',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 0, 34, 2)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  nome.length > 2 ? nome.substring(0, 2) : 'A',
                  style: TextStyle(
                      fontSize: 40.0, color: Color.fromARGB(255, 0, 34, 2), fontFamily: 'Montserrat-S'),
                ),
              ),
              accountName: Text(nome, style: TextStyle(fontFamily: 'Montserrat-S')),
              accountEmail: Text(email, style: TextStyle(fontFamily: 'Montserrat-S')),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Text(
                "Perfil",
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
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
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
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
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
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
      backgroundColor: Color.fromARGB(255, 0, 34, 2),
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
                      Text('Cadastrar Atirador',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: 'Montserrat-S',
                          )),
                      IconButton(
                        icon: Icon((Icons.person)),
                        iconSize: 30,
                        enableFeedback: false,
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
                            margin: EdgeInsets.fromLTRB(15, 12, 15, 0),
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
                                      })
                              ),
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
                          Container(
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
                                  value: pelotaoController.text,
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
                                  value: funcaoController.text,
                                  onChanged: (String? value) {
                                    setState(() {
                                      funcaoController.text = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                            child: ElevatedButton(
                              onPressed: () => cadastrarUsuario(context),
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

  void initState() {
    super.initState();

    final user = carregaUsuario();
    //validar se o usuário está logado
    /* if (user == null) {
      Navigator.pushNamed(context, '/login');
    }*/
  }
}
