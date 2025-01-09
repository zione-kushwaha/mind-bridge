import 'package:flutter/material.dart';
import '/themes/text_styles.dart';
import '/themes/theme_config.dart';

class CustomCheckboxButton extends StatefulWidget {
  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  final bool? value;
  final Function(bool) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;
  final bool isExpandedText;

  CustomCheckboxButton({
    Key? key,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    required this.onChange,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
  }) : super(key: key);

  @override
  _CustomCheckboxButtonState createState() => _CustomCheckboxButtonState();
}

class _CustomCheckboxButtonState extends State<CustomCheckboxButton> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: buildCheckBoxWidget,
          )
        : buildCheckBoxWidget;
  }

  Widget get buildCheckBoxWidget => InkWell(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
          widget.onChange(isChecked);
        },
        child: Container(
          decoration: widget.decoration,
          width: widget.width,
          child: (widget.isRightCheck ?? false)
              ? rightSideCheckbox
              : leftSideCheckbox,
        ),
      );

  Widget get leftSideCheckbox => Row(
        children: [
          Padding(
            child: checkboxWidget,
            padding: EdgeInsets.only(right: 8),
          ),
          widget.isExpandedText ? Expanded(child: textWidget) : textWidget,
        ],
      );

  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: checkboxWidget,
          ),
        ],
      );

  Widget get textWidget => Text(
        widget.text ?? "",
        textAlign: widget.textAlignment ?? TextAlign.center,
        style: widget.textStyle ?? CustomTextStyles.bodySmallBlue300,
      );

  Widget get checkboxWidget => SizedBox(
        height: widget.iconSize,
        width: widget.iconSize,
        child: Checkbox(
          visualDensity: VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: isChecked,
          activeColor: appTheme.amberA700,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
            widget.onChange(isChecked);
          },
        ),
      );
}
