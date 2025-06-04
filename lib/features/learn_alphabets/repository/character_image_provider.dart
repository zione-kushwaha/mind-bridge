import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final characterImageProvider =
    FutureProvider.family<CharacterImageResponse, String>((ref, letter) async {
  final response = await http.get(Uri.parse(
      'http://mindbridge.dipeshacharya.tech/api/game-images/$letter/'));
  // 'https://pleasing-guppy-hardy.ngrok-free.app/api/game-images/$letter/'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return CharacterImageResponse.fromJson(data);
  } else {
    throw Exception('Failed to load character image');
  }
});

class CharacterImageResponse {
  final String? characterImageUrl;
  final List<ImageData>? images;

  CharacterImageResponse({this.characterImageUrl, this.images});

  factory CharacterImageResponse.fromJson(Map<String, dynamic> json) {
    var imagesList = json['data']['images'] as List;
    List<ImageData> images =
        imagesList.map((i) => ImageData.fromJson(i)).toList();

    return CharacterImageResponse(
      characterImageUrl: json['data']['character_image_url'],
      images: images,
    );
  }
}

class ImageData {
  final String? imageUrl;
  final String? description;

  ImageData({this.imageUrl, this.description});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }
}
