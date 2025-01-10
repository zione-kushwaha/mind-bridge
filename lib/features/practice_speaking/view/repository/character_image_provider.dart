import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class CharacterImageResponse {
  final String characterImageUrl;
  final List<ImageData> images;

  CharacterImageResponse({
    required this.characterImageUrl,
    required this.images,
  });

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
  final String imageUrl;
  final String description;
  final String? additionalImage1Url;
  final String? additionalImage2Url;

  ImageData({
    required this.imageUrl,
    required this.description,
    this.additionalImage1Url,
    this.additionalImage2Url,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imageUrl: json['image_url'],
      description: json['description'],
      additionalImage1Url: json['additional_image_1_url'],
      additionalImage2Url: json['additional_image_2_url'],
    );
  }
}

class CharacterImageProvider {
  final String baseurl =
      'https://pleasing-guppy-hardy.ngrok-free.app/api/game-images';

  Future<CharacterImageResponse> fetchCharacterImage(String letter) async {
    final response = await http.get(Uri.parse('$baseurl/$letter'));

    if (response.statusCode == 200) {
      return CharacterImageResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load character image');
    }
  }
}

final characterImageProviderSpeakingPractice =
    FutureProvider.family<CharacterImageResponse, String>((ref, letter) async {
  final characterImageProvider = CharacterImageProvider();
  return await characterImageProvider.fetchCharacterImage(letter);
});
