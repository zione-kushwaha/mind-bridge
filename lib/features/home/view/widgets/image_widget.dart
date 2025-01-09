import 'package:flutter/material.dart';

import '../../model/image_data.dart';

class ImageWidget extends StatelessWidget {
  final imageData location;

  const ImageWidget({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      /// space from white container
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.5,
      width: size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            buildImage(context),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildTopText(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) => Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Image.asset(location.urlImage, fit: BoxFit.fill),
          ),
        ),
      );

  Widget buildTopText() => Container(
        padding: EdgeInsets.only(right: 50),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              location.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
}
