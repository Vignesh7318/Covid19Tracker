import 'package:covid19/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19',
      home: startScreen(),
    );
  }
}

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/covid19.jpg"),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "COVID-19 Tracker\n",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        )),
                    TextSpan(
                        text: "\nStay Home Stay Safe",
                        style: TextStyle(color: Colors.black, fontSize: 20.0))
                  ]),
                )
              ],
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Dashboard();
                }));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.red),
                child: Row(
                  children: <Widget>[Text('View Details')],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
