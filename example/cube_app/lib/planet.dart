import 'dart:async';

import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'dart:math' as math;

class PlanetPage extends StatefulWidget {
  const PlanetPage({Key? key}) : super(key: key);

  @override
  _PlanetPageState createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage>
    with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _earth;
  late Object _stars;
  late AnimationController _controller;

  void generateSphereObject(
    Object parent,
    String name,
    double radius,
    bool backfaceCulling,
    String texturePath,
  ) async {
    final mesh =
        await generateSphereMesh(radius: radius, texturePath: texturePath);
    parent
        .add(Object(name: name, mesh: mesh, backfaceCulling: backfaceCulling));
    _scene.updateTexture();
  }

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    _scene.camera.position.z = 16;

    // model from https://free3d.com/3d-model/planet-earth-99065.html
    // _earth = Object(name: 'earth', scale: Vector3(10.0, 10.0, 10.0), backfaceCulling: true, fileName: 'assets/earth/earth.obj');

    // create by code
    _earth = Object(name: 'earth', scale: Vector3(10.0, 10.0, 10.0));
    generateSphereObject(
        _earth!, 'surface', 0.485, true, 'assets/earth/4096_earth.jpg');
    generateSphereObject(
        _earth!, 'clouds', 0.5, true, 'assets/earth/4096_clouds.png');
    _scene.world.add(_earth!);

    // texture from https://www.solarsystemscope.com/textures/
    _stars = Object(name: 'stars', scale: Vector3(2000.0, 2000.0, 2000.0));
    generateSphereObject(
        _stars, 'surface', 0.5, false, 'assets/stars/2k_stars.jpg');
    _scene.world.add(_stars);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 30000), vsync: this)
      ..addListener(() {
        if (_earth != null) {
          _earth!.rotation.y = _controller.value * 360;
          _earth!.updateTransform();
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
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('planet')),
      body: Cube(onSceneCreated: _onSceneCreated),
    );
  }
}

Future<Mesh> generateSphereMesh({
  num radius = 0.5,
  int latSegments = 32,
  int lonSegments = 64,
  required String texturePath,
}) async {
  final count = (latSegments + 1) * (lonSegments + 1);
  final vertices = List<Vector3>.filled(count, Vector3.zero());
  final texcoords = List<Offset>.filled(count, Offset.zero);
  final indices =
      List<Polygon>.filled(latSegments * lonSegments * 2, Polygon(0, 0, 0));

  int i = 0;
  for (int y = 0; y <= latSegments; ++y) {
    final double v = y / latSegments;
    final double sv = math.sin(v * math.pi);
    final double cv = math.cos(v * math.pi);
    for (int x = 0; x <= lonSegments; ++x) {
      final double u = x / lonSegments;
      vertices[i] = Vector3(radius * math.cos(u * math.pi * 2.0) * sv,
          radius * cv, radius * math.sin(u * math.pi * 2.0) * sv);
      texcoords[i] = Offset(1.0 - u, 1.0 - v);
      i++;
    }
  }

  i = 0;
  for (int y = 0; y < latSegments; ++y) {
    final int base1 = (lonSegments + 1) * y;
    final int base2 = (lonSegments + 1) * (y + 1);
    for (int x = 0; x < lonSegments; ++x) {
      indices[i++] = Polygon(base1 + x, base1 + x + 1, base2 + x);
      indices[i++] = Polygon(base1 + x + 1, base2 + x + 1, base2 + x);
    }
  }

  final texture = await loadImageFromAsset(texturePath);
  final Mesh mesh = Mesh(
    vertices: vertices,
    texcoords: texcoords,
    indices: indices,
    texture: texture,
    texturePath: texturePath,
  );
  return mesh;
}

Future<ui.Image> loadImageFromAsset(String fileName) async {
  final dataFuture =
      await rootBundle.load(fileName).then((data) => data.buffer.asUint8List());

  final codec = await instantiateImageCodec(dataFuture);
  final frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}
