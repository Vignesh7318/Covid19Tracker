import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Covid> fetchData() async {
  final response = await http.get(
      'https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true');
  if (response.statusCode == 200) {
    return Covid.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

class Covid {
  final int totalCases;
  final int deaths;
  final int activeCases;
  final int recovered;

  Covid({this.totalCases, this.deaths, this.activeCases, this.recovered});
  factory Covid.fromJson(Map<String, dynamic> jsno) {
    return Covid(
        totalCases: jsno['totalCases'],
        deaths: jsno['deaths'],
        activeCases: jsno['activeCases'],
        recovered: jsno['recovered']);
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<Covid> futureCovid;
  @override
  void initState() {
    futureCovid = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Covid>(
        future: futureCovid,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/covid19.jpg"),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Cases :',
                            style: TextStyle(fontSize: 30.0, color: Colors.red),
                          ),
                          Text(
                            snapshot.data.totalCases.toString(),
                            style: TextStyle(fontSize: 25.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Deaths :',
                            style: TextStyle(fontSize: 30.0, color: Colors.red),
                          ),
                          Text(
                            snapshot.data.deaths.toString(),
                            style: TextStyle(fontSize: 25.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Active Cases :',
                            style: TextStyle(
                                fontSize: 30.0, color: Colors.redAccent),
                          ),
                          Text(
                            snapshot.data.activeCases.toString(),
                            style: TextStyle(fontSize: 25.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Recovered :',
                            style: TextStyle(
                                fontSize: 30.0, color: Colors.deepOrange),
                          ),
                          Text(
                            snapshot.data.recovered.toString(),
                            style: TextStyle(fontSize: 25.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Designed by Invictus',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
