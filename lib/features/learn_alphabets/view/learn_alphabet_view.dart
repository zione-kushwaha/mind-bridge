import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:t/features/pallete_generator/repository.dart';

import '../repository/character_image_provider.dart';
import '../repository/character_notifier.dart';

class LearnAlphabetView extends ConsumerStatefulWidget {
  @override
  _LearnAlphabetViewState createState() => _LearnAlphabetViewState();
}

class _LearnAlphabetViewState extends ConsumerState<LearnAlphabetView> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speak(ref.read(
          characterProvider)); // Speak the first letter when the view is initialized
    });
  }

  void _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final currentChar = ref.watch(characterProvider);
    final characterImageAsyncValue =
        ref.watch(characterImageProvider(currentChar));

    void ontap() {
      ref.read(characterProvider.notifier).nextCharacter();
      final newChar = ref.read(characterProvider); // Get the updated character
      _speak(newChar); // Speak the current character when the button is pressed
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      body: characterImageAsyncValue.when(
        data: (characterImageResponse) {
          final characterImageUrl =
              characterImageResponse.characterImageUrl ?? '';
          final imageData = characterImageResponse.images?.first;

          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'LEARN ALPHABETS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Stack(
                children: [
                  Center(
                    child: Consumer(builder: (context, ref, child) {
                      final colorProvider = ref
                          .watch(paletteGeneratorProvider(characterImageUrl));
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: colorProvider.value,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    }),
                  ),
                  Positioned(
                      right: MediaQuery.of(context).size.width * 0.4,
                      top: 0,
                      child: Row(
                        children: [
                          Image.network(
                            imageData?.imageUrl ?? '',
                            height: MediaQuery.of(context).size.height * 0.1,
                          )
                        ],
                      )),
                  Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.007,
                      left: MediaQuery.of(context).size.width * 0.16,
                      child: GestureDetector(
                        onTap: () {
                          _speak(currentChar);
                        },
                        child: Image.asset(
                          'assets/first/15.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                      )),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(800),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      imageData?.description ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Image.network(
                characterImageUrl,
                height: MediaQuery.of(context).size.height * 0.3,
              )
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ontap,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
