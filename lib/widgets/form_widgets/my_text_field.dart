import 'package:egy_tour_guide/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/palette.dart';

class MyTextField extends StatelessWidget {

  void selectType (){}
   MyTextField({
     this.onTap ,
    this.icon = const Icon(Icons.abc),

    required this.hint,
    this.obscureText = false,
    required this.textInputAction,
    required this.textInputType,
    this.fillColor = kWhite,
    this.autofocus = false,
    this.validator,
    this.onSaved,
    this.texterror,
    this.controller,
    this.suffix,
    this.contentpading =
        const EdgeInsets.only(top: 17, left: 15, bottom: 15, right: 15),
    this.onChanged,
    this.enabled = true,
    this.isIconVisiblePrefix = true,
    this.isIconVisibleSuffix = true,
    this.maxLines = 1,
    this.enabledMaxLength = false,
    this.maxLength = 20,
    this.enabledBorderRadius = true,
    this.isKey,
    
  });
  final String hint;
  final Widget icon;
  final bool obscureText;
  final bool isIconVisiblePrefix;
  final bool isIconVisibleSuffix;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color fillColor;
  final bool autofocus;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final String? texterror;
  final TextEditingController? controller;
  final Widget? suffix;
  final EdgeInsets contentpading;
  final ValueChanged? onChanged;
  final bool enabled;
  final bool enabledBorderRadius;
  final bool enabledMaxLength;
  final int maxLines;
  final int maxLength;
  final VoidCallback? onTap;
  final Key? isKey ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: TextFormField(
        key: isKey,
        onTap:onTap,
        maxLines: maxLines,
        maxLength: enabledMaxLength ? maxLength : null,
        enabled: enabled,
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        textInputAction: textInputAction,
        style: const TextStyle(
            color: Colors.blue, fontSize: 15, fontFamily: 'ElMessiri'),
        keyboardType: textInputType,
        autofocus: autofocus,
        decoration: InputDecoration(
          errorText: texterror,
          focusColor: Colors.blue,
          fillColor: fillColor,
          filled: true,
          // focus
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.5,
            ),
            borderRadius: enabledBorderRadius
                ? BorderRadius.circular(50)
                : BorderRadius.circular(0),
          ),
          // enabled
          enabledBorder: OutlineInputBorder(
              borderRadius: enabledBorderRadius
                  ? BorderRadius.circular(50)
                  : BorderRadius.circular(0),
              borderSide: BorderSide.none),
          // disabled
          disabledBorder: OutlineInputBorder(
              borderRadius: enabledBorderRadius
                  ? BorderRadius.circular(50)
                  : BorderRadius.circular(0),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 149, 149, 149))),
          // enabled error
          errorBorder: OutlineInputBorder(
              borderRadius: enabledBorderRadius
                  ? BorderRadius.circular(50)
                  : BorderRadius.circular(0),
              borderSide: const BorderSide(color: Colors.red)),
          // focusedErrorBorder
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: enabledBorderRadius
                ? BorderRadius.circular(50)
                : BorderRadius.circular(0),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          contentPadding: contentpading,
          suffix: isIconVisiblePrefix ? suffix : null,
          prefixIcon: isIconVisiblePrefix ? icon : null,
          hintText: hint,

          hintStyle: const TextStyle(color: kGray, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
