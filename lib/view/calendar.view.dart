import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tg_app/view/alteracaoGuarnicaoComandantes.view.dart';
import 'package:tg_app/view/cadastroGuarnicaoComandantes.view.dart';
import 'package:timeago/timeago.dart';

class CalendarPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<CalendarPage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<dynamic, dynamic> map = {};
  String nomeCabo = "";
  String nomeCom = "";

  verificaExistenciaData(focusDay) async {
    var a = await firestore
        .collection('guardas')
        .doc(DateFormat('yyyy-MM-dd').format(focusDay).toString())
        .get();
    if (a.exists) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => alteracaoGuarnicaoComandantes(
                data: focusDay,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CadastroGuarnicaoComandantes(
                data: focusDay,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Selecione a Data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 500,
            width: 500,
            child: TableCalendar(
              firstDay: DateTime.utc(2022, 02, 01),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              calendarStyle: CalendarStyle(
                cellMargin: EdgeInsets.all(10),
                //defaultTextStyle: TextStyle(fontSize: 15),
                weekendTextStyle: TextStyle(fontSize: 15, color: Colors.red),
                holidayTextStyle: TextStyle(fontSize: 15, color: Colors.red),
              ),
              headerStyle: HeaderStyle(
                formatButtonTextStyle: const TextStyle(fontSize: 15.0),
                headerMargin: const EdgeInsets.all(5),
                titleTextStyle: TextStyle(fontSize: 20.0),
              ),
              rowHeight: 60,
              weekendDays: [
                DateTime.saturday,
                DateTime.sunday,
              ],
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                  print(focusDay);
                  verificaExistenciaData(focusDay);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
