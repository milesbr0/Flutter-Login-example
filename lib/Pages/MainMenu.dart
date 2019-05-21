import 'package:flutter/material.dart';

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {

  //TODO: PROFILKEP
  //TODO: FELHASZNALO NEVE
  //TODO: UJ KOD BEOLVASASA(UNITY BRIDGE)
  //TODO: NYEREMENYEIM
  //TODO: NYEREMENYEK
  //TODO: JATEKSZABALYZAT
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(top:30),
              height: 30,
              width: 30,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFff639f)
              ),
            ),
            new Text('FELHASZNALO NEVE'),
            new Row(
              children: <Widget>[
                new Stack(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 59, top:139),
                      height: 118.0,
                      width: 118.0,
                      decoration: new BoxDecoration(
                          boxShadow: [new BoxShadow(color: Colors.black,
                              blurRadius: 10.0)],
                          shape: BoxShape.circle,
                          color: Color(0xFFffffff)
                      ),
                    ), //Container : button background
                    new Container(
                      margin: new EdgeInsets.only(left: 78, top: 158),
                      height: 80,
                      width: 80,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                        color: Color(0xFFff639f)
                      ),
                    ) //Container : button icon
                  ],
                ), //Stack: Scan new code
                new Stack(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 30, top:139),
                      height: 118.0,
                      width: 118.0,
                      decoration: new BoxDecoration(
                          boxShadow: [new BoxShadow(color: Colors.black,
                              blurRadius: 10.0)],
                          shape: BoxShape.circle,
                          color: Color(0xFFff639f)
                      ),
                    ), //Container : Button Background
                    new Container(
                      margin: new EdgeInsets.only(left: 49, top: 158),
                      height: 80,
                      width: 80,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFffffff)
                      ),
                    ) //Container : Button Icon
                  ],
                ), //Stack: My rewards
              ],
            ), //First Row
            new Row(
              children: <Widget>[
                new Stack(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 59, top:60),
                      height: 118.0,
                      width: 118.0,
                      decoration: new BoxDecoration(
                          boxShadow: [new BoxShadow(color: Colors.black,
                              blurRadius: 10.0)],
                          shape: BoxShape.circle,
                          color: Color(0xFF4b4469)
                      ),
                    ), //Container : Button background
                    new Container(
                      margin: new EdgeInsets.only(left: 78, top: 79),
                      height: 80,
                      width: 80,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFff639f)
                      ), //decoration
                    ) //Container : Button icon
                  ],
                ), //Stack: Rewards
                new Stack(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 30, top:60),
                      height: 118.0,
                      width: 118.0,
                      decoration: new BoxDecoration(
                          boxShadow: [new BoxShadow(color: Colors.black,
                              blurRadius: 10.0)],
                          shape: BoxShape.circle,
                          color: Color(0xFF4b4469)
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.only(left: 49, top: 79),
                      height: 80,
                      width: 80,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFff639f)
                      ),
                    )
                  ],
                ) //Stack: Rules
              ],
            ) //Second Row
          ],
        ) //Column

      )// body Center
    ); //Scaffold
  }


}