import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'repository/character_image_provider.dart';

class PracticeSpeaking extends ConsumerStatefulWidget {
  const PracticeSpeaking({super.key});

  @override
  ConsumerState<PracticeSpeaking> createState() => _PracticeSpeakingState();
}

class _PracticeSpeakingState extends ConsumerState<PracticeSpeaking>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _firstVisibleIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final FlutterTts flutterTts = FlutterTts();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _currentLetter = 'a';
  bool is_listening = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _initSpeech();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: false); // Auto-repeats the animation.
    _seupAnimation();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      sampleRate: 1,
      partialResults: false,
    );

    setState(() {
      is_listening = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      _stopListening();
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      is_listening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _checkResult();
    });
  }

  void _seupAnimation() {
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _onScroll() {
    final firstVisibleIndex =
        (_scrollController.offset / MediaQuery.of(context).size.width * 0.3)
            .round();
    setState(() {
      _firstVisibleIndex = firstVisibleIndex;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _checkResult() {
    String first_letter =
        _lastWords.isNotEmpty ? _lastWords[0].toLowerCase() : '';
    if (first_letter == _currentLetter) {
      setState(() {
        isCorrect = true;
        _controller.reset();
        _controller.forward();
      });
    } else {
      setState(() {
        isCorrect = false;
      });
      _showIncorrectDialog();
    }
  }

  void _showIncorrectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incorrect'),
          content: Icon(Icons.close, color: Colors.red, size: 50),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _nextLetter() {
    setState(() {
      _currentLetter = String.fromCharCode(_currentLetter.codeUnitAt(0) + 1);
      isCorrect = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final middleY = MediaQuery.of(context).size.height * 0.5;
    final screenHeight = MediaQuery.of(context).size.height;
    final centerx = screenWidth / 2 - 25;
    final provider =
        ref.watch(characterImageProviderSpeakingPractice(_currentLetter));

    return Scaffold(
      body: provider.when(
        data: (characterImageResponse) {
          final characterImageUrl = characterImageResponse.characterImageUrl;
          final imageData = characterImageResponse.images;
          final data = imageData.toList();
          final img_1 = data[0];

          final image = img_1.imageUrl;
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'SPEAKING PRACTICE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                              ),
                              Container(
                                child: Image.asset('assets/alphabets/17.png'),
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Column(
                            children: [
                              Container(
                                child: Image.asset('assets/alphabets/18.png'),
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              Container(
                                child: Image.asset('assets/alphabets/17.png'),
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    isCorrect
                        ? AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              double t =
                                  _animation.value; // Animation progress [0, 1]
                              double x = t * screenWidth; // Horizontal movement
                              double y = 100 -
                                  100 *
                                      (1 -
                                          4.5 *
                                              (t - 0.5) *
                                              (t - 0.5)); // Parabolic formula

                              return Positioned(
                                left: x,
                                top: y,
                                child: Image.network(
                                  img_1.imageUrl,
                                  width: 50,
                                  height: 50,
                                ),
                              );
                            },
                          )
                        : Container(
                            child: Image.network(
                              img_1.imageUrl,
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                        img_1.additionalImage2Url ??
                            'https://via.placeholder.com/150',
                        height: MediaQuery.of(context).size.height * 0.15),
                    Image.network(characterImageUrl,
                        height: MediaQuery.of(context).size.height * 0.1),
                    Image.network(
                        img_1.additionalImage1Url ??
                            'https://via.placeholder.com/150',
                        height: MediaQuery.of(context).size.height * 0.13)
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _startListening();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.4),
                        padding: EdgeInsets.all(23),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Speak',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: is_listening
                          ? Image.asset('assets/alphabets/25.png',
                              width: 300, height: 300)
                          : isCorrect
                              ? Image.asset('assets/alphabets/20.png',
                                  width: 300, height: 300)
                              : Image.asset('assets/alphabets/21.png',
                                  width: 300, height: 300),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _nextLetter,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
