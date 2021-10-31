import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cube/src/model_provider/model_provider.dart';

class FileModelProvider extends ModelProvider {
  FileModelProvider(this.path);

  final String path;

  @override
  Future<Uint8List> loadAsset(String path) {
    return File(path).readAsBytes();
  }

  @override
  Future<String> loadMaterial(String mtl) {
    return File(mtl).readAsString();
  }

  @override
  Future<String> loadObject() {
    return File(path).readAsString();
  }
}
