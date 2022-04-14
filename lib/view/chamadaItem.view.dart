import 'package:flutter/material.dart';

class ChamadaItem extends StatefulWidget {
  const ChamadaItem({Key? key}) : super(key: key);

  @override
  State<ChamadaItem> createState() => _ChamadaItemState();
}

class _ChamadaItemState extends State<ChamadaItem> {
  bool checkboxListTileValue = false;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Color(0xFF95A1AC),
      ),
      child: CheckboxListTile(
        value: checkboxListTileValue ??= arguments['presenca'],
        onChanged: (newValue) =>
            setState(() => checkboxListTileValue = newValue!),
        title: Text(
          arguments['nome'].toString(),
          style: TextStyle(),
        ),
        subtitle: Text(
          arguments['funcao'].toString(),
          style: TextStyle(),
        ),
        tileColor: Color(0xFFF5F5F5),
        activeColor: Colors.red,
        dense: false,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
