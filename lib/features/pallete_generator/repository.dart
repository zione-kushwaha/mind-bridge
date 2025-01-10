import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

final paletteGeneratorProvider =
    FutureProvider.family<Color, String>((ref, imageUrl) async {
  final image = NetworkImage(imageUrl);
  final paletteGenerator = await PaletteGenerator.fromImageProvider(image);
  return paletteGenerator.dominantColor?.color ??
      Colors.red; // Return the dominant color or a default color
});
