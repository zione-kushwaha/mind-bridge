import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/image_data_data.dart';
import 'image_data_widget.dart';

class templateWidget extends StatefulWidget {
  @override
  _templateWidgetState createState() => _templateWidgetState();
}

class _templateWidgetState extends State<templateWidget> {
  final pageController = PageController(viewportFraction: 0.8);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    Text(
                      'Hi, Samridhi',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.63,
            child: PageView.builder(
              controller: pageController,
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];

                return LocationWidget(location: location);
              },
              onPageChanged: (index) => setState(() => pageIndex = index),
            ),
          ),
          Text(
            '${pageIndex + 1}/${locations.length}',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 12)
        ],
      );
}
