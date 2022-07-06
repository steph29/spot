// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:spot/object/main_title_text.dart';
import 'package:spot/object/section_title.dart';
import 'package:spot/object/store_book.dart';
import 'package:spot/second_page.dart';
import 'object/store.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:flutter/cupertino.dart';


void main() {
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spot',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: const MyHomePage(title: 'Spot'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
    });
  }

  List<Store> stores = [
    Store("Suisse", "C'est trop jolie", false, 45.98, -4.7, 'imagePath', 0, 0,
        "5 minutes")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserLocation();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _getUserLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Divider(thickness: 2,),
            SectionTitle("A propos de moi"),
            Divider(thickness: 2,),
            SectionTitle("Amis"),
            Divider(thickness: 2,),
            SectionTitle("Mes Posts"),
            allPosts()


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorCustom,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: colorCustom,
        clipBehavior: Clip.hardEdge,
        child: Text(
          "this is the bottom",
          textAlign: TextAlign.center,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Column allPosts() {
    List<Widget> postToAdd = [];
    stores.forEach((element) {
      postToAdd.add(store(store: element));
    });
    return Column(children: postToAdd,);
  }

  Container store({required Store store}) {
    return Container(
    
      child: Column(
        children: [
           Padding(padding: EdgeInsets.only(left: 8)),
              Text(store.name),
              Spacer(),
              Text(store.setTime()),
            Text(store.setCommentaire(),
            style: TextStyle(
              color: Colors.blueAccent),
            textAlign: TextAlign.center,
          ),
          Divider(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.favorite),
              Text(store.setLike()),
              Icon(Icons.message),
              Text(store.setCommentaire())
        ],
          ),
        ],
      ),
    );
  }
} 
