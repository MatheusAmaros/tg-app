import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tg_app/model/atiradorEdicao.model.dart';


class atiradorEdit  extends StatefulWidget {
  final AtiradorModel atirador;
  const atiradorEdit({ 
    Key? key,
    required this.atirador
    }) : super(key: key);

  @override
  State<atiradorEdit> createState() => _atiradorEditState();
}

class _atiradorEditState extends State<atiradorEdit> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.atirador.nome) ),
    
    
      
    );
  }
}

