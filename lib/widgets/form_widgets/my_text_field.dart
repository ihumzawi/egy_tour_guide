import 'package:egy_tour_guide/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:egy_tour_guide/palette.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.hint,
    required this.icon,
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
        const EdgeInsets.only(top: 17, left: 15, bottom: 15, right: 15), this.onChanged,
  }) : super(key: key);
  final String hint;
  final Widget icon;
  final bool obscureText;
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
  final ValueChanged? onChanged ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: TextFormField(
        controller: controller,
        onSaved: onSaved,
        onChanged: onChanged ,
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
            borderRadius: BorderRadius.circular(50),
          ),
          // enabled
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          // enabled error
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.red)),
          //focusedErrorBorder
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.redAccent)),
          contentPadding: contentpading,

          suffix: suffix,

          prefixIcon: icon,
          hintText: hint,
          hintStyle: const TextStyle(color: kGray, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
