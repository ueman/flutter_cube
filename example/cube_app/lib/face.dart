import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class FacePage extends StatefulWidget {
  FacePage({Key? key}) : super(key: key);

  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage>
    with SingleTickerProviderStateMixin {
  void _onSceneCreated(Scene scene) {
    scene.camera.position.z = 10;
    scene.camera.target.y = 2;
    // from https://github.com/mikedh/trimesh
    scene.world.add(Object(
        scale: Vector3(5.0, 5.0, 5.0),
        modelfile: AssetModelProvider('assets/face.obj')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('face'),
      ),
      body: Center(
        child: Cube(
          onSceneCreated: _onSceneCreated,
        ),
      ),
    );
  }
}
