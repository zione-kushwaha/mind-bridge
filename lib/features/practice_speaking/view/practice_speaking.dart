import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PracticeSpeaking extends StatefulWidget {
  const PracticeSpeaking({super.key});

  @override
  State<PracticeSpeaking> createState() => _PracticeSpeakingState();
}

class _PracticeSpeakingState extends State<PracticeSpeaking>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  int _firstVisibleIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final FlutterTts flutterTts = FlutterTts();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool is_listening = false;

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

    Future.delayed(Duration(seconds: 2), () {
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
      print(_lastWords);
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final middleY = MediaQuery.of(context).size.height * 0.5;
    final screenHeight = MediaQuery.of(context).size.height;
    final centerx = screenWidth / 2 - 25;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'SPEAKING PRACTICE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
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
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/alphabets/17.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/alphabets/18.png',
                            height: MediaQuery.of(context).size.height * .1,
                          ),
                          Container(
                            child: Image.asset(
                              'assets/alphabets/17.png',
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                4 < 3
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
                            child: Image.asset(
                              'assets/letter/a.png',
                              width: 50,
                              height: 50,
                            ),
                          );
                        },
                      )
                    : Container()
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Speak',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: is_listening
                      ? Image.asset('assets/alphabets/19.png')
                      : Image.asset('assets/alphabets/20.png'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _speechEnabled
          ? FloatingActionButton(
              onPressed: _startListening,
              child: Icon(Icons.mic),
            )
          : null,
    );
  }
}
