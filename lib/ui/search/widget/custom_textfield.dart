import 'package:flutter/material.dart';

enum TextFieldType { name, country }

class CustomTextField extends StatelessWidget {
  final TextFieldType textFieldType;
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  const CustomTextField(
      {Key? key,
      required this.textFieldType,
      required this.textEditingController,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextField(
        style: style,
        onChanged: onChanged,
        controller: textEditingController,
        autofocus: true,
        cursorHeight: 19,
        decoration: InputDecoration(
          hintText: getHint,
          hintStyle: textStyle,
          fillColor: Colors.grey.withOpacity(0.3),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle get textStyle {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.grey.withOpacity(0.70));
  }

  TextStyle get style {
    return const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black);
  }

  String get getHint {
    switch (textFieldType) {
      case TextFieldType.name:
        return "Employee name";
      case TextFieldType.country:
        return "Country";
    }
  }
}
