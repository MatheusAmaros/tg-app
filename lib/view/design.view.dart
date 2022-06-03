import 'package:flutter/material.dart';

class Design extends StatelessWidget {
  final value = true;
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
                        onPressed: () {},
                      ),
                      Text('Home', style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Montserrat-S',)),
                      IconButton(
                        icon: Icon((Icons.perm_identity_sharp)),
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
                child: ListView.builder( 
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (_, index){
                    return Center( child: Text("Design"));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
