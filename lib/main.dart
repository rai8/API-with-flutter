import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
//import 'package:technology/screens/map_page.dart';
//import 'package:technology/screens/post_page.dart';
//import 'package:technology/screens/home_page.dart';
//import 'package:technology/screens/list_page.dart';';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
    
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
   
  //     _counter++;
  //   });
  // }

  final location = new Location();
  String locationError;
  PrayerTimes prayerTimes;

  @override
  void initState() {
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        setState(() {
          prayerTimes = PrayerTimes(
              Coordinates(locationData.latitude, locationData.longitude),
              DateComponents.from(DateTime.now()),
              CalculationMethod.karachi.getParameters());
        });
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });

    super.initState();
  }

  Future<LocationData> getLocationData() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            Builder(
              builder: (BuildContext context) {
                if (prayerTimes != null) {
                  return Column(
                    children: [
                      Text(
                        'Prayer Times for Today',
                        textAlign: TextAlign.center,
                      ),
                      Text('Fajr Time: ' +
                          DateFormat.jm().format(prayerTimes.fajr)),
                      Text('Sunrise Time: ' +
                          DateFormat.jm().format(prayerTimes.sunrise)),
                      Text('Dhuhr Time: ' +
                          DateFormat.jm().format(prayerTimes.dhuhr)),
                      Text('Asr Time: ' +
                          DateFormat.jm().format(prayerTimes.asr)),
                      Text('Maghrib Time: ' +
                          DateFormat.jm().format(prayerTimes.maghrib)),
                      Text('Isha Time: ' +
                          DateFormat.jm().format(prayerTimes.isha)),
                    ],
                  );
                }
                if (locationError != null) {
                  return Text(locationError);
                }
                return Text('Waiting for Your Location...');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

