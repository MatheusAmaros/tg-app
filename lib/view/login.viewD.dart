import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';





class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool passwordVisibility = true;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String erro = '';


  void _handleFirebaseLoginWithCredentialsException(
      FirebaseAuthException e, StackTrace s) {
    if (e.code == 'user-disabled') {
      //'O usuário informado está desabilitado.'
      erro = 'Usuário desabilitado no sistema';
    } else if (e.code == 'user-not-found') {
      //'O usuário informado não está cadastrado.'
      erro = 'Usuário não cadastrado no sistema';
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

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      

      try {
        var result = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

  
        Navigator.of(context)
            .pushNamed('/home', arguments: {'userUid': result.user!.uid});
      } on FirebaseAuthException catch (e, s) {
        _handleFirebaseLoginWithCredentialsException(e, s);
       

          emailController.clear();
          passwordController.clear();

          Fluttertoast.showToast(
              msg: erro,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb:3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
              webPosition: 'center');
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            //repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.dstATop),
            image: Image.asset('assets/images/camuflagem2.jpg',).image,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0, bottom: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( child: Image(image: AssetImage('assets/images/exercito.png'), height: 150,),
                   
                  ),
                ],
              ),
            ),
            Expanded(
              
              child: Container(
                
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70.0)),
                  ),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(child: Text('Login',style: TextStyle(fontFamily: 'Montserrat',fontSize: 32,fontWeight: FontWeight.w900 ),),
                        ),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            style: TextStyle( fontFamily: 'Montserrat-S'),
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat-S',
                                  color: Color.fromARGB(255, 165, 165, 165),),
                              
                            ),
                            onSaved: (value) => emailController.text = value!,
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Campo E-mail é obrigatório";

                              if (!emailValid.hasMatch(value))
                                return "Formato de email inserido está incorreto";

                              return null;
                            },
                          ),
                         
                        ),
                         Container(
                          child:  TextFormField(
                            obscureText: passwordVisibility,
                            controller: passwordController,
                            style: TextStyle( fontFamily: 'Montserrat-S'),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat-S',
                                  color: Color.fromARGB(255, 165, 165, 165),),
                              suffixIcon:  IconButton(
                icon: Icon(
                  passwordVisibility ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed:  (){ setState(() {
                    passwordVisibility = !passwordVisibility;
                  });})
                                  
                              
                            ),
                            onSaved: (value) => passwordController.text = value!,
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Campo Senha é obrigatório";

                              return null;
                            },
                          ),
                          
                        ),
                        ElevatedButton(
                            onPressed: () => save(context),
                            child: Text("Login"),
                            style: ElevatedButton.styleFrom(
                               shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
),
                                primary: Color.fromARGB(255, 36, 35, 35),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 130, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
