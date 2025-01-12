import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t/themes/sizes.dart';

import '../../../themes/image_paths.dart';
import '../../../themes/text_styles.dart';
import '../../../themes/theme_config.dart';

import '../widget/custom_checkbox_bottom.dart';
import '../widget/image_view.dart';

class ReadSettingsPageScreen extends StatefulWidget {
  final Function(RichText, bool) updateTextCallback;
  final Function(Color) updateBackgroundColorCallback;
  final Function(RichText, TextStyle) updateTextAndStyleCallback;
  final Function(bool) updateBrightnessCallback;
  final Function onCloseOverlay;
  Color scaffoldBackgroundColor;
  bool passbright;
  bool isRoboto;
  RichText chapter;
  late RichText oldChapter = chapter;
  late TextStyle originalStyle;

  ReadSettingsPageScreen(
      {required this.updateTextCallback,
      required this.chapter,
      required this.updateBackgroundColorCallback,
      required this.scaffoldBackgroundColor,
      required this.updateTextAndStyleCallback,
      required this.updateBrightnessCallback,
      required this.passbright,
      required this.isRoboto,
      required this.onCloseOverlay}) {
    oldChapter = chapter;
    originalStyle = oldChapter.text.style ?? TextStyle();
  }

  @override
  State<ReadSettingsPageScreen> createState() => _ReadSettingsPageScreenState();
}

class _ReadSettingsPageScreenState extends State<ReadSettingsPageScreen> {
  double customFontSize = 14.0;

  double customLineSpacing = 1.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            height: 30,
            color: Colors.green,
          ),
          Container(
            height: 1.v,
            color: appTheme.whiteA700,
          ),
          _buildGridBar(),
        ],
      ),
    );
  }

  Widget _buildTopBar(context) {
    return AppBar(
      elevation: 0,
      backgroundColor: appTheme.blue300,
      leading: CustomImageView(
        imagePath: ImageConstant.imgVector9,
        height: 24.h,
        width: 24.h,
        margin: EdgeInsets.symmetric(vertical: 15.v),
        onTap: () {
          onTapVectorNine(context);
        },
      ),
      actions: [
        CustomImageView(
          imagePath: ImageConstant.imgSearchWhiteA700,
          height: 24.h,
          width: 24.h,
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          onTap: () {},
        ),
        CustomImageView(
          imagePath: ImageConstant.imgStarOutline,
          height: 24.h,
          width: 24.h,
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          onTap: () {},
        ),
        CustomImageView(
          imagePath: ImageConstant.imgBookmark,
          height: 24.h,
          width: 24.h,
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          onTap: () {},
        ),
        CustomImageView(
          imagePath: ImageConstant.imgMegaphoneWhiteA700,
          height: 24.h,
          width: 24.h,
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildGridBar() {
    return Container(
      padding: EdgeInsets.all(5.h),
      color: Colors.green,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGridItem("Open Dyslexic/\n     Roboto", 4,
                  hasBackground: true,
                  onChange: applychangeFont,
                  onAntiChange: applychangeFont),
              _buildGridItem("Auto Brightness ", 6,
                  checkValue: widget.passbright,
                  hasBackground: false,
                  onChange: autoBright,
                  onAntiChange: antiBright),
              _buildGridItem("Focus Mode", 5,
                  hasBackground: false,
                  onChange: focusMode,
                  onAntiChange: antiFocusMode),
            ],
          ),
          SizedBox(height: 2.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // _buildCustomImageView(ImageConstant.imgTextLineSpacing,
              //     onTap: lineSpacingUp),

              // SizedBox(width: 2.v),
              // _buildCustomImageView(ImageConstant.imgLineSpacingDown,
              //     onTap: lineSpacingDown),
              IconButton(
                  onPressed: lineSpacingUp,
                  icon: Icon(
                    Icons.format_line_spacing,
                    size: 30,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 30,
              ),
              IconButton(
                  onPressed: lineSpacingDown,
                  icon: Icon(
                    Icons.arrow_downward,
                    size: 30,
                    color: Colors.white,
                  )),
              SizedBox(width: 2.v),
              _buildCustomImageView(ImageConstant.imgFontUp, onTap: fontDown),
              SizedBox(width: 2.v),
              _buildCustomImageView(ImageConstant.imgFontDown, onTap: fontUp),
              _buildGridItem(
                "Vertical Scroll",
                6,
                checkValue: true,
                hasBackground: false,
              ),
              _buildGridItem(
                "Thickness  ",
                5,
                hasBackground: false,
                onChange: thiccMode,
                onAntiChange: antiThiccMode,
              ),
            ],
          ),
          SizedBox(height: 4.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColoredItem("Aa", 1, appTheme.black900,
                  CustomTextStyles.bodyLargeWhite9000,
                  onTap: updateNightMode),
              SizedBox(width: 30.h),
              _buildColoredItem("Aa", 1, appTheme.surface,
                  CustomTextStyles.bodyLargeGray90001,
                  onTap: updateSurfaceMode),
              SizedBox(width: 30.h),
              _buildColoredItem(
                  "Aa", 1, appTheme.gray50, CustomTextStyles.bodyLargeGray90001,
                  onTap: updateDefaultMode)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomImageView(String imagePath, {Function? onTap}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: CustomImageView(
          height: 20.h,
          width: 20.h,
          imagePath: imagePath,
        ),
      ),
    );
  }

  Widget _buildGridItem(String text, int flex,
      {bool checkValue = false,
      bool hasBackground = true,
      Function? onChange,
      Function? onAntiChange}) {
    bool valued = false;
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () {
          valued = !valued;
          if (valued) {
            onChange?.call();
          } else {
            onAntiChange?.call();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: hasBackground ? appTheme.amberA700 : null,
            borderRadius: BorderRadius.circular(10.h),
          ),
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 5.v),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasBackground ? SizedBox(width: 0.h) : SizedBox(width: 18.h),
              Text(
                text,
                style: CustomTextStyles.bodySmallWhite9000,
              ),
              if (!hasBackground) ...[
                SizedBox(width: 1.h),
                CustomCheckboxButton(
                  value: checkValue,
                  text: (null),
                  onChange: (value) {
                    if (value) {
                      onChange?.call();
                    } else {
                      onAntiChange?.call();
                    }
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColoredItem(
      String text, int flex, Color backgroundColor, TextStyle textStyle,
      {Function? onTap}) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.h),
            color: backgroundColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: Center(
            child: Text(text, style: textStyle),
          ),
        ),
      ),
    );
  }

  void autoBright() {
    widget.passbright = true;
    widget.updateBrightnessCallback(true);
  }

  void antiBright() {
    widget.passbright = false;
    widget.updateBrightnessCallback(false);
  }

  RichText Bionic(String text, double fontSize, double lineSpacing) {
    final TextSpan inputTextSpan = widget.chapter.text as TextSpan;

    List<TextSpan> formattedText = [];

    List<String> words = text.split(' ');

    for (String word in words) {
      final int halfLength = (word.length / 2).ceil();
      final String boldPart = word.substring(0, halfLength);
      final String regularPart = word.substring(halfLength);

      formattedText.add(
        TextSpan(
          text: boldPart,
          style: TextStyle(
            fontFamily: inputTextSpan.style?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: widget.originalStyle.color,
            height: lineSpacing,
          ),
        ),
      );

      formattedText.add(
        TextSpan(
          text: regularPart,
          style: TextStyle(
            fontFamily: inputTextSpan.style?.fontFamily,
            fontSize: fontSize,
            color: widget.originalStyle.color,
            height: lineSpacing,
          ),
        ),
      );

      formattedText.add(TextSpan(text: ' '));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: inputTextSpan.style?.fontFamily,
          fontSize: fontSize,
          color: widget.originalStyle.color,
          height: lineSpacing,
        ),
        children: formattedText,
      ),
      textAlign: TextAlign.left,
    );
  }

  RichText antiBionic(String text, double fontSize, double lineSpacing) {
    final TextSpan inputTextSpan = widget.chapter.text as TextSpan;

    List<TextSpan> formattedText = [];

    List<String> words = text.split(' ');

    for (String word in words) {
      formattedText.add(
        TextSpan(
          text: word,
          style: TextStyle(
            fontFamily: inputTextSpan.style?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: fontSize,
            color: widget.originalStyle.color,
            height: lineSpacing,
          ),
        ),
      );
      formattedText.add(TextSpan(text: ' '));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: inputTextSpan.style?.fontFamily,
          fontSize: fontSize,
          color: widget.originalStyle.color,
          height: lineSpacing,
        ),
        children: formattedText,
      ),
      textAlign: TextAlign.left,
    );
  }

  void focusMode() {
    String chapterText = widget.oldChapter.text.toPlainText();
    RichText bionicText =
        Bionic(chapterText, customFontSize, customLineSpacing);
    widget.chapter = bionicText;
    widget.oldChapter = widget.chapter;
    widget.originalStyle = widget.oldChapter.text.style ?? TextStyle();
    widget.updateTextCallback(bionicText, widget.isRoboto);
  }

  void antiFocusMode() {
    String chapterText = widget.oldChapter.text.toPlainText();
    RichText newText =
        antiBionic(chapterText, customFontSize, customLineSpacing);
    widget.chapter = newText;
    widget.oldChapter = widget.chapter;
    widget.originalStyle = widget.oldChapter.text.style ?? TextStyle();
    widget.updateTextCallback(newText, widget.isRoboto);
  }

  RichText AntiThickness(String text, double fontSize, double lineSpacing) {
    final TextSpan inputTextSpan = widget.chapter.text as TextSpan;

    List<TextSpan> formattedText = [];

    List<String> words = text.split(' ');

    for (String word in words) {
      formattedText.add(
        TextSpan(
          text: word,
          style: TextStyle(
            fontFamily: inputTextSpan.style?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: fontSize,
            color: widget.originalStyle.color,
            height: lineSpacing,
          ),
        ),
      );
      formattedText.add(TextSpan(text: ' '));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: inputTextSpan.style?.fontFamily,
          fontSize: fontSize,
          color: widget.originalStyle.color,
          height: lineSpacing,
        ),
        children: formattedText,
      ),
      textAlign: TextAlign.left,
    );
  }

  RichText Thickness(String text, double fontSize, double lineSpacing) {
    final TextSpan inputTextSpan = widget.chapter.text as TextSpan;

    List<TextSpan> formattedText = [];

    List<String> words = text.split(' ');

    for (String word in words) {
      formattedText.add(
        TextSpan(
          text: word,
          style: TextStyle(
            fontFamily: inputTextSpan.style?.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
            color: widget.originalStyle.color,
            height: lineSpacing,
          ),
        ),
      );

      formattedText.add(TextSpan(text: ' '));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: inputTextSpan.style?.fontFamily,
          fontSize: fontSize,
          color: widget.originalStyle.color,
          height: lineSpacing,
        ),
        children: formattedText,
      ),
      textAlign: TextAlign.left,
    );
  }

  void thiccMode() {
    String chapterText = widget.oldChapter.text.toPlainText();
    RichText thiccText =
        Thickness(chapterText, customFontSize, customLineSpacing);
    widget.chapter = thiccText;
    widget.oldChapter = widget.chapter;
    widget.originalStyle = widget.oldChapter.text.style ?? TextStyle();
    widget.updateTextCallback(thiccText, widget.isRoboto);
  }

  void antiThiccMode() {
    String chapterText = widget.oldChapter.text.toPlainText();
    RichText thiccText =
        AntiThickness(chapterText, customFontSize, customLineSpacing);
    widget.chapter = thiccText;
    widget.oldChapter = widget.chapter;
    widget.originalStyle = widget.oldChapter.text.style ?? TextStyle();
    widget.updateTextCallback(thiccText, widget.isRoboto);
  }

  void fontUp() {
    if (customFontSize <= 24) {
      customFontSize += 2.0;
      applyFontSize();
    }
  }

  void fontDown() {
    if (customFontSize >= 12) {
      customFontSize -= 2.0;
      applyFontSize();
    }
  }

  void applyFontSize() {
    final TextSpan inputTextSpan = widget.oldChapter.text as TextSpan;
    TextStyle originalStyle = inputTextSpan.style ?? TextStyle();
    originalStyle = originalStyle.copyWith(fontSize: customFontSize);

    List<TextSpan> newTextSpans = [];
    newTextSpans.add(
      TextSpan(
        text: inputTextSpan.text,
        style: originalStyle,
      ),
    );

    for (var child in inputTextSpan.children ?? []) {
      if (child is TextSpan) {
        newTextSpans.add(
          TextSpan(
            text: child.text,
            style: child.style?.copyWith(fontSize: customFontSize),
            children: child.children,
          ),
        );
      }
    }

    widget.oldChapter = RichText(
      text: TextSpan(
        style: originalStyle,
        children: newTextSpans,
      ),
    );

    widget.chapter = widget.oldChapter;

    widget.updateTextCallback(widget.chapter, widget.isRoboto);
  }

  void lineSpacingUp() {
    final TextSpan inputTextSpan = widget.oldChapter.text as TextSpan;
    final double originalLineSpacing = inputTextSpan.style?.height ?? 1.0;

    // Increase line spacing by 0.2, but not exceeding a certain limit
    final double newLineSpacing = (originalLineSpacing + 0.2).clamp(1.0, 2.0);

    applyLineSpacing(newLineSpacing);
  }

  void lineSpacingDown() {
    final TextSpan inputTextSpan = widget.oldChapter.text as TextSpan;
    final double originalLineSpacing = inputTextSpan.style?.height ?? 1.0;

    // Decrease line spacing by 0.2, but not going below a certain limit
    final double newLineSpacing = (originalLineSpacing - 0.2).clamp(0.9, 2.0);

    applyLineSpacing(newLineSpacing);
  }

  void applyLineSpacing(double newLineSpacing) {
    customLineSpacing = newLineSpacing;

    final TextSpan inputTextSpan = widget.oldChapter.text as TextSpan;
    // Ensure to get the latest originalStyle
    final TextStyle originalStyle = inputTextSpan.style ?? TextStyle();

    final TextStyle updatedStyle =
        originalStyle.copyWith(height: newLineSpacing);

    List<TextSpan> newTextSpans = [];
    newTextSpans.add(
      TextSpan(
        text: inputTextSpan.text,
        style: updatedStyle,
      ),
    );

    for (var child in inputTextSpan.children ?? []) {
      if (child is TextSpan) {
        newTextSpans.add(
          TextSpan(
            text: child.text,
            style: child.style?.copyWith(height: customLineSpacing),
            children: child.children,
          ),
        );
      }
    }

    widget.oldChapter = RichText(
      text: TextSpan(
        style: updatedStyle,
        children: newTextSpans,
      ),
    );

    widget.chapter = widget.oldChapter;

    widget.updateTextCallback(widget.chapter, widget.isRoboto);
  }

  RichText changeFont(RichText currentText, String font, double fontSize,
      double lineSpacing, bool isBold) {
    final TextSpan inputTextSpan = currentText.text as TextSpan;

    List<TextSpan> formattedText = [];

    List<String> words = currentText.text.toPlainText().split(' ');

    for (String word in words) {
      formattedText.add(
        TextSpan(
          text: word,
          style: TextStyle(
            fontFamily: font,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
            color: currentText.text.style?.color,
            height: lineSpacing,
          ),
        ),
      );
      formattedText.add(TextSpan(text: ' '));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: font,
          fontSize: fontSize,
          color: currentText.text.style?.color,
          height: lineSpacing,
        ),
        children: formattedText,
      ),
      textAlign: TextAlign.left,
    );
  }

  void applychangeFont() {
    String customFont = 'assets/fonts/OpenDyslexicRegular.ttf';
    print(widget.isRoboto);
    if (widget.isRoboto == false) {
      customFont = 'assets/fonts/RobotoMedium.ttf';
      print("before change: ${widget.isRoboto}");
      widget.isRoboto = true;
      print("after change: ${widget.isRoboto}");
    } else {
      print("else before change: ${widget.isRoboto}");
      customFont = 'OpenDyslexic';
      widget.isRoboto = false;
      print("else after change: ${widget.isRoboto}");
    }
    print(customFont);
    RichText updatedText = changeFont(widget.oldChapter, customFont,
        customFontSize, customLineSpacing, false);
    widget.chapter = updatedText;
    widget.oldChapter = widget.chapter;
    widget.originalStyle = widget.oldChapter.text.style ?? TextStyle();
    widget.updateTextCallback(updatedText, widget.isRoboto);
  }

  void updateNightMode() {
    widget.updateBackgroundColorCallback(appTheme.black900);
    final TextStyle whiteStyle =
        widget.originalStyle.copyWith(color: appTheme.whiteA700);
    final RichText updatedRichText = RichText(
      text: TextSpan(
        style: whiteStyle,
        text: widget.oldChapter.text.toPlainText(),
      ),
    );
    widget.updateTextAndStyleCallback(updatedRichText, whiteStyle);
  }

  void updateDefaultMode() {
    widget.updateBackgroundColorCallback(appTheme.whiteA700);
    final TextStyle blackStyle =
        widget.originalStyle.copyWith(color: appTheme.black900);

    final RichText updatedRichText = RichText(
      text: TextSpan(
        style: blackStyle,
        text: widget.oldChapter.text.toPlainText(),
      ),
    );

    widget.updateTextAndStyleCallback(updatedRichText, blackStyle);
  }

  void updateSurfaceMode() {
    widget.updateBackgroundColorCallback(appTheme.surface);

    final TextStyle surfaceStyle =
        widget.originalStyle.copyWith(color: appTheme.black900);

    final RichText updatedRichText = RichText(
      text: TextSpan(
        style: surfaceStyle,
        text: widget.oldChapter.text.toPlainText(),
      ),
    );

    widget.updateTextAndStyleCallback(updatedRichText, surfaceStyle);
  }

  void updateTextAndBackgroundColor(Color backgroundColor, Color textColor) {
    widget.updateBackgroundColorCallback(backgroundColor);
  }

  void onTapVectorNine(BuildContext context) {
    HapticFeedback.vibrate();
    widget.onCloseOverlay();
    Navigator.pop(context);
  }
}
