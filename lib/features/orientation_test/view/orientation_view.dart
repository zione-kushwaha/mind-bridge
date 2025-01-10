import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:t/features/orientation_test/provider/request_response.dart'
    as img;

class OrientationView extends ConsumerStatefulWidget {
  const OrientationView({super.key});

  @override
  ConsumerState<OrientationView> createState() => _OrientationViewState();
}

class _OrientationViewState extends ConsumerState<OrientationView> {
  String currentLetter = 'a';
  List<int> randomizedIndices = List.generate(9, (index) => index);
  final Random random = Random();
  Map<int, bool?> imageStates = {};
  bool correctResponseSelected = false;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    randomizeIndices();
    _speak(
        currentLetter); // Speak the first letter when the view is initialized
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.5);
    await flutterTts.speak(text);
  }

  void randomizeIndices() {
    randomizedIndices.shuffle(random);
    imageStates.clear();
    correctResponseSelected = false;
  }

  void onNext() {
    setState(() {
      currentLetter = String.fromCharCode(currentLetter.codeUnitAt(0) + 1);
      randomizeIndices();
      _speak(currentLetter);
    });
  }

  void onTryAgain() {
    setState(() {
      randomizeIndices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  'Orientation Test',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Consumer(builder: (context, ref, child) {
                final imgsAsyncValue =
                    ref.watch(img.imageProcessorProvider(currentLetter));
                return imgsAsyncValue.when(
                  data: (imageResponse) {
                    final images = imageResponse.images;
                    return GridView.builder(
                      padding: EdgeInsets.only(top: 50, left: 120, right: 120),
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final image = images[randomizedIndices[index]];
                        final imageState =
                            imageStates[randomizedIndices[index]];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (!correctResponseSelected) {
                                imageStates[randomizedIndices[index]] =
                                    image.isCorrect;
                                if (image.isCorrect) {
                                  correctResponseSelected = true;
                                }
                              }
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Center(
                                    child: Image.network(
                                      image.imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                              if (imageState != null)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: Icon(
                                        imageState
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: imageState
                                            ? Colors.green
                                            : Colors.red,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Consumer(builder: (context, ref, child) {
                final imgsAsyncValue =
                    ref.watch(img.imageProcessorProvider(currentLetter));
                return imgsAsyncValue.when(
                  data: (imageResponse) {
                    final characterImageUrl = imageResponse.characterImageUrl;
                    return Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        height: MediaQuery.of(context).size.height * 0.15,
                        characterImageUrl,
                      ),
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _speak(currentLetter);
                  },
                  child: Image.asset(
                    height: MediaQuery.of(context).size.height * 0.1,
                    'assets/first/15.png',
                  ),
                ),
                Image.asset(
                  height: MediaQuery.of(context).size.height * 0.15,
                  'assets/first/14.png',
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onTryAgain,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onNext,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
