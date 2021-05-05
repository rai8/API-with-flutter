import 'package:flutter/material.dart';
import 'package:technology/services/list_api.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future lists;
  @override
  void initState() {
    super.initState();
    lists = fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetching List from API'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.pink[900],
      ),
      body: FutureBuilder(
          future: lists,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data;
              return Text(
        list.toString(),
        style: TextStyle(fontSize: 26.0),
      );
            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            else{
              return Center(child: CircularProgressIndicator());

            }
          },
        ),
    );
  }
}
