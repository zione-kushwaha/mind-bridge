class CharacterImageResponse {
  final String characterImageUrl;
  final List<ImageData> images;

  CharacterImageResponse(
      {required this.characterImageUrl, required this.images});

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

  ImageData({required this.imageUrl, required this.description});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }
}
