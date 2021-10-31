import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'dart:math';

class CubePage extends StatefulWidget {
  CubePage({Key? key, this.title = 'Cube'}) : super(key: key);

  final String title;

  @override
  _CubePageState createState() => _CubePageState();
}

class _CubePageState extends State<CubePage>
    with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _cube;
  late AnimationController _controller;

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    scene.camera.position.z = 50;
    _cube = Object(
      scale: Vector3(2.0, 2.0, 2.0),
      backfaceCulling: false,
      modelfile: AssetModelProvider('assets/cube/cube.obj'),
    );
    final int samples = 100;
    final double radius = 8;
    final double offset = 2 / samples;
    final double increment = pi * (3 - sqrt(5));
    for (var i = 0; i < samples; i++) {
      final y = (i * offset - 1) + offset / 2;
      final r = sqrt(1 - pow(y, 2));
      final phi = ((i + 1) % samples) * increment;
      final x = cos(phi) * r;
      final z = sin(phi) * r;
      final Object cube = Object(
        position: Vector3(x, y, z)..scale(radius),
        modelfile: AssetModelProvider('assets/cube/cube.obj'),
      );
      _cube!.add(cube);
    }
    scene.world.add(_cube!);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 30000), vsync: this)
      ..addListener(() {
        if (_cube != null) {
          _cube!.rotation.y = _controller.value * 360;
          _cube!.updateTransform();
          _scene.update();
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Cube(
          onSceneCreated: _onSceneCreated,
        ),
      ),
    );
  }
}
