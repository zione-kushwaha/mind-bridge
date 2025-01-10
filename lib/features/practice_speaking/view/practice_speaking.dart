import 'package:flutter/material.dart';
import 'dart:math' as math;

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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: false); // Auto-repeats the animation.

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
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    double t = _animation.value; // Animation progress [0, 1]
                    double x = t * screenWidth; // Horizontal movement
                    double y = 100 -
                        100 *
                            (1 -
                                4 * (t - 0.5) * (t - 0.5)); // Parabolic formula

                    return Positioned(
                      left: x,
                      top: y,
                      child: Image.asset(
                        'assets/letter/a.png', // Replace with your image path
                        width: 50,
                        height: 50,
                      ),
                    );
                  },
                ),
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
                    'Animate',
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
                  child: Image.asset('assets/alphabets/19.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
