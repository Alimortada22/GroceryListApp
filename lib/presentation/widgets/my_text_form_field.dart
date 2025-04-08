import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({super.key, required this.textformfieldcontroller,required this.hintText,required this.validator});
  final TextEditingController textformfieldcontroller;
  final String hintText;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator(value),
      
      controller: textformfieldcontroller,
      decoration: InputDecoration(
          hintText:hintText ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }
}
