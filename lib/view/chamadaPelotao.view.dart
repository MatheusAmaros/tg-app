import 'package:flutter/material.dart';

class ChamadaPelotaoView extends StatelessWidget {
  final value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 37, 3),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.dstATop),
            image: Image.asset('assets/images/camuflagem2.jpg',).image,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded),
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text('Chamada', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Montserrat-S',)),
                      IconButton(
                        icon: Icon((Icons.perm_identity_sharp)),
                        iconSize: 30,
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
                child: ListView(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  children: <Widget>[
                    ListTile(
                      title: Text("Pelotão 1", style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat-S',)),
                      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade900),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/chamada', arguments: {'pelotao': '1'});
                      }
                    ),
                    ListTile(
                      title: Text("Pelotão 2", style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat-S',)),
                      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade900),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/chamada', arguments: {'pelotao': '2'});
                      }
                    ),
                    ListTile(
                      title: Text("Pelotão 3", style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat-S',)),
                      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade900),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/chamada', arguments: {'pelotao': '3'});
                      }
                    ),
                    ListTile(
                      title: Text("Pelotão 4", style: TextStyle(color: Colors.grey.shade900, fontFamily: 'Montserrat-S',)),
                      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade900),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/chamada', arguments: {'pelotao': '4'});
                      }
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
