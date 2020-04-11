import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/values/colors.dart';

class BeautyTextfield extends StatefulWidget {



  final BorderRadius cornerRadius;
  final TextEditingController controller;
  final double width, height, wordSpacing;
  final Color backgroundColor, accentColor, textColor, eyeColor;
  final String placeholder, fontFamily;
  final Icon prefixIcon, suffixIcon;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final EdgeInsets margin;
  final Duration duration;
  final VoidCallback onClickSuffix;
  final TextBaseline textBaseline;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow, passwordIcon;
  final FocusNode focusNode;
  final int maxLength, minLines, maxLines;
  final ValueChanged<String> onChanged, onSubmitted;
  final GestureTapCallback onTap;

  const BeautyTextfield(
      {@required this.width,
        @required this.height,
        @required this.inputType,
        this.prefixIcon,
        this.suffixIcon,
        this.eyeColor,
        this.passwordIcon = false,
        this.controller,
        this.inputAction,
        this.duration = const Duration(milliseconds: 500),
        this.margin = const EdgeInsets.all(10),
        this.obscureText = false,
        this.backgroundColor = const Color(0xff111823),
        this.cornerRadius = const BorderRadius.all(Radius.circular(10)),
        this.textColor =  Colors.black,
        this.accentColor = Colors.white,
        this.placeholder = "",
        this.isShadow = true,
        this.onClickSuffix,
        this.wordSpacing,
        this.textBaseline,
        this.fontFamily,
        this.fontStyle,
        this.fontWeight,
        this.autofocus = false,
        this.autocorrect = false,
        this.focusNode,
        this.enabled = true,
        this.maxLength,
        this.maxLines,
        this.minLines,
        this.onChanged,
        this.onTap,
        this.onSubmitted})
      : assert(width != null),
        assert(height != null),
        assert(inputType != null);

  @override
  _BeautyTextfieldState createState() => _BeautyTextfieldState();
}

class _BeautyTextfieldState extends State<BeautyTextfield> {

  bool passwordVisible = false;

  bool isFocus = false;

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          boxShadow: widget.isShadow
              ? [BoxShadow(color: Colors.transparent, blurRadius: 0, spreadRadius: 0)]
              : BoxShadow(spreadRadius: 0, blurRadius: 0),
          borderRadius: widget.cornerRadius,
          color: widget.suffixIcon == null
              ? isFocus ? widget.accentColor : widget.backgroundColor
              : widget.backgroundColor),
      child: Stack(
        children: <Widget>[
          widget.suffixIcon == null
              ? Container()
              : Align(
            alignment: Alignment.centerRight,
            child: AnimatedContainer(
              width: isFocus ? widget.width : 40,
              height: isFocus ? widget.height : 40,
              margin: EdgeInsets.only(right: isFocus ? 0 : 7),
              duration: widget.duration,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isFocus ? AppColors.secondaryBackground: Colors.transparent, //                   <--- border color
                  width: 2.0,
                ),
                borderRadius: isFocus
                    ? widget.cornerRadius
                    : BorderRadius.all(Radius.circular(60)),
                color: isFocus? widget.accentColor : Colors.transparent,
              ),
            ),
          ),
          widget.suffixIcon == null
              ? Container()
              : GestureDetector(
            onTap: () {
              setState(() {
                isFocus ? isFocus = false : isFocus = true;
                if (widget.onClickSuffix != null) {
                  widget.onClickSuffix();
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              child: Icon(
                widget.passwordIcon?
                     passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off

                    : Icons.remove_red_eye,

                color:  widget.passwordIcon? widget.eyeColor : Colors.transparent,
              ),
            ),
          ),
          Container(
            height: 50,
            width: widget.width-15,
            margin: widget.passwordIcon? EdgeInsets.only(left: 8, right: 50): EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: widget.controller,
              cursorWidth: 2,

              obscureText: widget.obscureText? !passwordVisible: false,
              keyboardType: widget.inputType,
              style: TextStyle(
                fontFamily: widget.fontFamily,
                fontStyle: widget.fontStyle,
                fontWeight: widget.fontWeight,
                wordSpacing: widget.wordSpacing,
                textBaseline: widget.textBaseline,
                fontSize: 18,
                color: widget.textColor,
              ),
              autofocus: widget.autofocus,
              autocorrect: widget.autocorrect,
              focusNode: widget.focusNode,
              enabled: widget.enabled,
              maxLength: widget.maxLength,
              maxLines: 1,
              minLines: widget.minLines,
              onChanged: widget.onChanged,

              onTap: () {
                setState(() {
                 isFocus = true;
                });
                if (widget.onTap != null) {
                  print('Focus');
                  widget.onTap();
                }
              },
              onSubmitted: (t) {
                setState(() {
                  isFocus = false;
                });
                widget.onSubmitted(t);
              },
              textInputAction: widget.inputAction,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: widget.textColor),
                  hintText: widget.placeholder,
                  border: InputBorder.none),
              cursorColor:
              isFocus ? widget.accentColor : widget.backgroundColor,
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap:  () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              child: Container(
                width: 50,
              height: 50,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      duration: widget.duration,
    );
  }
}