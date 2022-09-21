import 'package:flutter/material.dart';
import 'package:flutter_chat/app/const/spoqa.dart';

class ChatroomCreateInputField extends StatelessWidget {
  const ChatroomCreateInputField({Key? key, required this.controller, this.onChange, required this.hintText}) : super(key: key);

  final TextEditingController controller;
  final Function(String value)? onChange;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        onChange?.call(value);
      },
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: Spoqa.grey_s14_w400,
        floatingLabelStyle: Spoqa.black_s14_w400,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      cursorColor: Colors.black,
    );
  }
}
