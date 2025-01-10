import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'communication.dart';

class CharacterImageProvider with ChangeNotifier {
  CharacterImageResponse? _characterImageResponse;
  bool _isLoading = false;

  CharacterImageResponse? get characterImageResponse => _characterImageResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchCharacterImage() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'https://pleasing-guppy-hardy.ngrok-free.app/api/alphabet-images/a/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _characterImageResponse = CharacterImageResponse.fromJson(data);
    } else {
      throw Exception('Failed to load character image');
    }

    _isLoading = false;
    notifyListeners();
  }
}
