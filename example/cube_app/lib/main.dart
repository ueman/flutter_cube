import 'package:cube_app/bunny.dart';
import 'package:cube_app/cube.dart';
import 'package:cube_app/face.dart';
import 'package:cube_app/planet.dart';
import 'package:cube_app/ruby.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cube',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('cube')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return const CubePage();
              }));
            },
            child: const Text('Cube example'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return const FacePage();
              }));
            },
            child: const Text('face example'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return const BunnyPage();
              }));
            },
            child: const Text('bunny example'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return const PlanetPage();
              }));
            },
            child: const Text('planet example'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) {
                return const RubyPage();
              }));
            },
            child: const Text('ruby example'),
          ),
        ],
      ),
    );
  }
}
