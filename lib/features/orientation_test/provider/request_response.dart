import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Image {
  final String imageUrl;
  final bool isCorrect;

  Image({required this.imageUrl, required this.isCorrect});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      imageUrl: json['image_url'],
      isCorrect: json['is_correct'],
    );
  }
}

class ImageProcessor {
  final url = 'https://mindbridge.pythonanywhere.com/api/alphabet-images/';

  Future<List<Image>> fetchImages(String letter) async {
    final response = await http.get(Uri.parse('$url/$letter/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final images = data['data']['images'] as List;
      return images.map((image) => Image.fromJson(image)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}

final imageProcessorProvider =
    FutureProvider.family<List<Image>, String>((ref, letter) async {
  final imageProcessor = ImageProcessor();
  return await imageProcessor.fetchImages(letter);
});
