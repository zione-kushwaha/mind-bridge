import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterNotifier extends StateNotifier<String> {
  CharacterNotifier() : super('a');

  void nextCharacter() {
    state = String.fromCharCode(state.codeUnitAt(0) + 1);
  }
}

final characterProvider =
    StateNotifierProvider<CharacterNotifier, String>((ref) {
  return CharacterNotifier();
});
