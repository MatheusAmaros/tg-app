import 'package:flutter/material.dart';

class ChamadaItem extends StatefulWidget {
  final String? nome;
  final String? funcao;
  final String? uuid;
  ChamadaItem({
    Key? key,
    @required this.uuid,
    @required this.nome,
    @required this.funcao,
  }) : super(key: key);

  @override
  State<ChamadaItem> createState() => _ChamadaItemState();
}

class _ChamadaItemState extends State<ChamadaItem> {
  bool checkboxListTileValue = false;

  /*
  void sendMessage() async {
    var message = txtCtrl.text;
    await firestore.collection('conversas').add({
      "message": message,
      "data": DateTime.now(),
      "email": auth.currentUser!.email,
      "usuarios": [
        auth.currentUser!.uid,
        ,
      ]
    });
    txtCtrl.clear();

    //firestore.collection('conversas').doc('123').
  }
  */

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Color(0xFF95A1AC),
      ),
      child: CheckboxListTile(
        value: checkboxListTileValue != false,
        onChanged: (newValue) {
          setState(() => checkboxListTileValue = newValue!);
        },
        title: Text(
          widget.nome.toString(),
          style: TextStyle(),
        ),
        subtitle: Text(
          widget.funcao.toString(),
          style: TextStyle(),
        ),
        tileColor: Color(0xFFF5F5F5),
        activeColor: Color.fromARGB(255, 25, 68, 0),
        dense: false,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
