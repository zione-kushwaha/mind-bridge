import 'package:flutter/material.dart';

import '../../../text_reconization/view/text_view.dart';
import '../../model/image_data.dart';

class ExpandedContentWidget extends StatefulWidget {
  final imageData location;
  final bool istapped;

  const ExpandedContentWidget({required this.location, required this.istapped});

  @override
  State<ExpandedContentWidget> createState() => _ExpandedContentWidgetState();
}

class _ExpandedContentWidgetState extends State<ExpandedContentWidget> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0x0ffcfb92).withOpacity(0.7),
            Color(0x0ffcfb92),
            Color(0xFF008037)
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 8),
            widget.istapped
                ? InkWell(
                    onTap: () {
                      if (widget.location.name == 'SCAN TEXT') {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    TextReconization(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: 0.0, end: 1.0)
                                  .chain(CurveTween(curve: curve));
                              var scaleAnimation = animation.drive(tween);

                              return ScaleTransition(
                                scale: scaleAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('START'),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
}
