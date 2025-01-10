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

class ImageResponse {
  final String characterImageUrl;
  final List<Image> images;

  ImageResponse({required this.characterImageUrl, required this.images});

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    final images = (json['data']['images'] as List)
        .map((image) => Image.fromJson(image))
        .toList();
    return ImageResponse(
      characterImageUrl: json['data']['character_image_url'],
      images: images,
    );
  }
}

class ImageProcessor {
  final url = 'https://mindbridge.pythonanywhere.com/api/alphabet-images/';

  Future<ImageResponse> fetchImages(String letter) async {
    final response = await http.get(Uri.parse('$url/$letter/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ImageResponse.fromJson(data);
    } else {
      throw Exception('Failed to load images');
    }
  }
}

final imageProcessorProvider =
    FutureProvider.family<ImageResponse, String>((ref, letter) async {
  final imageProcessor = ImageProcessor();
  return await imageProcessor.fetchImages(letter);
});
