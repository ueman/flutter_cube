import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cube/src/model_provider/model_provider.dart';

class AssetModelProvider extends ModelProvider {
  AssetModelProvider(
    this.objectPath, {
    AssetBundle? assetBundle,
  }) : _assetBundle = assetBundle ?? rootBundle;

  final String objectPath;
  final AssetBundle _assetBundle;

  @override
  Future<Uint8List> loadAsset(String path) async {
    final byteData = await _assetBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  @override
  Future<String> loadMaterial(String mtl) {
    return _assetBundle.loadString(objectPath);
  }

  @override
  Future<String> loadObject() {
    return _assetBundle.loadString(objectPath);
  }
}
