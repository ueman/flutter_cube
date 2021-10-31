import 'dart:typed_data';

abstract class ModelProvider {
  Future<String> loadObject();
  Future<String> loadMaterial(String mtl);
  Future<Uint8List> loadAsset(String path);
}
