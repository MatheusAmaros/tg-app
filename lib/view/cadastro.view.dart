import 'package:flutter/material.dart';

class CadastroAtirador extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

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
            width: 400,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "CADASTRAR ATIRADOR",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.account_circle_outlined,
                            size: 40, color: Color.fromARGB(255, 0, 0, 0))
                      ],
                    ),
                    TextFormField(
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
                    TextFormField(
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
                          prefixIcon: Icon(Icons.email)),
                      onSaved: (value) => () {}, //nome = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo nome obrigatório";
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 165, 165, 165)),
                          labelText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          prefixIcon: Icon(Icons.password)),
                      obscureText: true,
                      onSaved: (value) => () {}, //senha = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo senha obrigatório";
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Cadastrar"),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color.fromARGB(255, 0, 0, 0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 110, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
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
