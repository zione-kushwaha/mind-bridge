import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void initState() {
    super.initState();
    randomizeIndices();
  }

  void randomizeIndices() {
    randomizedIndices.shuffle(random);
  }

  void onNext() {
    setState(() {
      currentLetter = String.fromCharCode(currentLetter.codeUnitAt(0) + 1);
      randomizeIndices();
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
                  data: (images) {
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
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (image.isCorrect) {
                                // Handle correct image tap
                              } else {
                                // Handle incorrect image tap
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 2),
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
              child: Image.asset(
                height: MediaQuery.of(context).size.height * 0.15,
                'assets/first/15.png',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  height: MediaQuery.of(context).size.height * 0.15,
                  'assets/first/15.png',
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
