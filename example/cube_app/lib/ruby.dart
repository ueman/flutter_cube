import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class RubyPage extends StatefulWidget {
  const RubyPage({Key? key}) : super(key: key);

  @override
  _RubyPageState createState() => _RubyPageState();
}

class _RubyPageState extends State<RubyPage>
    with SingleTickerProviderStateMixin {
  void _onSceneCreated(Scene scene) {
    scene.camera.position.z = 10;
    scene.camera.target.y = 2;
    // from https://sketchfab.com/3d-models/ruby-rose-2270ee59d38e409491a76451f6c6ef80
    scene.world.add(
      Object(
        scale: Vector3(10.0, 10.0, 10.0),
        modelfile: AssetModelProvider('assets/ruby_rose/ruby_rose.obj'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ruby'),
      ),
      body: Center(
        child: Cube(
          onSceneCreated: _onSceneCreated,
        ),
      ),
    );
  }
}
