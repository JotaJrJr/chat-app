import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String)? onSubmitted;
  final int? maxLines;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.textInputType = TextInputType.text,
    this.onSubmitted,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onSubmitted: onSubmitted,
        keyboardType: textInputType,
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: false,
        ),
      ),
    );
  }
}
