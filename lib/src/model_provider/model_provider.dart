import 'dart:typed_data';

import 'dart:ui';

abstract class ModelProvider {
  Future<String> loadObject();
  Future<String> loadMaterial(String mtl);
  Future<Uint8List> loadAsset(String path);
}

extension ModelProviderX on ModelProvider {
  /// load an image from asset
  Future<Image> loadImage(String fileName) async {
    final data = await loadAsset(fileName);

    final codec = await instantiateImageCodec(data);
    final frameInfo = await codec.getNextFrame();

    return frameInfo.image;
  }
}
