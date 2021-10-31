import 'package:cube_app/bunny.dart';
import 'package:cube_app/cube.dart';
import 'package:cube_app/planet.dart';
import 'package:cube_app/ruby.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cube',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('cube')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return CubePage();
              }));
            },
            child: Text('Cube example'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return BunnyPage();
              }));
            },
            child: Text('bunny example'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return PlanetPage();
              }));
            },
            child: Text('planet example'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return RubyPage();
              }));
            },
            child: Text('ruby example'),
          ),
        ],
      ),
    );
  }
}
