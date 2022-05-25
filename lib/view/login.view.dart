import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController textController1 = new TextEditingController();
  TextEditingController textController2 = new TextEditingController();

  bool passwordVisibility = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String email = '';
  String senha = '';

  String erro = '';

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
  }

  void _handleFirebaseLoginWithCredentialsException(
      FirebaseAuthException e, StackTrace s) {
    if (e.code == 'user-disabled') {
      //'O usuário informado está desabilitado.'
      erro = 'Usuário desabilitado no sistema';
    } else if (e.code == 'user-not-found') {
      //'O usuário informado não está cadastrado.'
      erro = 'Usuário não cadastrado';
    } else if (e.code == 'invalid-email') {
      //'O domínio do e-mail informado é inválido.'
      erro = 'Email ou senha invalido';
    } else if (e.code == 'wrong-password') {
      //'A senha informada está incorreta.'
      erro = 'Email ou senha invalido';
    } else {
       erro = 'Entre em contato com o administrador do sistema';
    }
  }

  void save(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    erro ='';
    
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        var result = await auth.signInWithEmailAndPassword(
            email: email, password: senha);

        // result.user!.updateDisplayName(displayName)
        Navigator.of(context).pushNamed('/home', arguments: {'userUid': result.user!.uid});
      } on FirebaseAuthException catch (e, s) {
        _handleFirebaseLoginWithCredentialsException(e, s);
        setState(() {
          email ='';
          senha ='';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF262D34),
      body: Container(
        width: 500,
        height: 900,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/f9dhs_4.jpg',
            ).image,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 380,
              height: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Colors.black,
                    offset: Offset(0, -15),
                    spreadRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (erro.isNotEmpty)
                        Text(
                          erro,
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Color.fromARGB(255, 196, 17, 17),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 1),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 165, 165, 165)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                          ),
                          onSaved: (value) => email = value!,
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Campo E-mail é obrigatório";

                            if (!emailValid.hasMatch(value))
                              return "Formato de email inserido está incorreto";

                            return null;
                          },
                        ),
                      ),
                      TextFormField(
                        controller: textController2,
                        onSaved: (value) => senha = value!,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Campo Senha é obrigatório";
                          return null;
                        },
                        obscureText: !passwordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 165, 165, 165)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                            ),
                            child: Icon(
                              passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF757575),
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () => save(context),
                          child: Text("Enter"),
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Color.fromARGB(255, 112, 112, 112),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 20),
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Não Tem cadastro? "),
                            GestureDetector(
                              child: Text("Cadastrar-se",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue)),
                              onTap: () =>
                                  Navigator.pushNamed(context, '/cadastro'),
                            )
                          ]),*/
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
