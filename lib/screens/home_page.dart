import 'package:flutter/material.dart';
import 'package:technology/services/string_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future stringResponse;
  @override
  void initState() {
    super.initState();
    stringResponse = fetchString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fetching String from API'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.blue[900],
        ),
        body: FutureBuilder(
          future: stringResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var string = snapshot.data;
              return Text(
        string.toString(),
        style: TextStyle(fontSize: 26.0),
      );
            }else{
              return Center(child: CircularProgressIndicator());

            }
          },
        ));
  }
}
