import 'package:flutter/material.dart';

class MyButtonForm extends StatelessWidget {
  const MyButtonForm({super.key,required this.buttonname,required this.onTap});
final String buttonname;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
                        onPressed: onTap,
                        child:  Text(
                          buttonname,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ));
  }
}