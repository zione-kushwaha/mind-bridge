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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Container(
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(screenHeight * 0.02),
              child: Center(
                child: Text(
                  'Orientation Test',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            SizedBox(
              height: screenHeight * 0.4,
              child: Consumer(builder: (context, ref, child) {
                final imgsAsyncValue =
                    ref.watch(img.imageProcessorProvider(currentLetter));
                return imgsAsyncValue.when(
                  data: (imageResponse) {
                    final images = imageResponse.images;
                    return GridView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: screenWidth * 0.02,
                        mainAxisSpacing: screenHeight * 0.02,
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
                                      fit: BoxFit.cover,
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
                                        size: screenHeight * 0.1,
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
                        characterImageUrl,
                        height: screenHeight * 0.15,
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
                    'assets/first/15.png',
                    height: screenHeight * 0.1,
                  ),
                ),
                Image.asset(
                  'assets/first/14.png',
                  height: screenHeight * 0.15,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onTryAgain,
                    child: Container(
                      padding: EdgeInsets.all(screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onNext,
                    child: Container(
                      padding: EdgeInsets.all(screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.025,
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
