import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../reader/view/reader_screen.dart';

class TextReconization extends StatefulWidget {
  const TextReconization({super.key});

  @override
  State<TextReconization> createState() => _TextReconizationState();
}

class _TextReconizationState extends State<TextReconization> {
  bool textIsScanning = false;
  XFile? imageFile;
  String scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Text Recognizer",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Scan the text from an image",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (textIsScanning) const CircularProgressIndicator(),
                if (!textIsScanning && imageFile == null)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 200,
                    ),
                  ),
                if (imageFile != null)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/first/12.png',
                                color: Colors.white,
                                width:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          getImage(ImageSource.camera);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/first/13.png',
                                color: Colors.white,
                                width:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                scannedText.isEmpty
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ReaderScreen(
                                  Text_to_Read: scannedText,
                                ),
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
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/first/11.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                ),
                                Text("Let's Analyse")
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        textIsScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognizedText(pickedImage);
      }
    } catch (e) {
      textIsScanning = false;
      imageFile = null;
      scannedText = "Error occurred while scanning.";
      setState(() {});
    }
  }

  void getRecognizedText(XFile img) async {
    final inputImage = InputImage.fromFilePath(img.path);
    final textRecognizer = TextRecognizer();

    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText += '${line.text}\n';
      }
    }

    textIsScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
}
