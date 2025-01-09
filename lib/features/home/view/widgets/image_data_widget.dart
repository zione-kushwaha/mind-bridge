import 'package:flutter/material.dart';

import '../../model/image_data.dart';
import 'expanded_widget.dart';
import 'image_widget.dart';

class LocationWidget extends StatefulWidget {
  final imageData location;

  const LocationWidget({
    required this.location,
  });

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.8 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            child: ExpandedContentWidget(
              location: widget.location,
              istapped: isExpanded,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: ImageWidget(location: widget.location),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
