import 'package:flutter/material.dart';

InputDecoration getInputDecoration({hintText}) {
  return InputDecoration(
    hintText: '$hintText'
  );
}

const INPUT_PADDING = EdgeInsets.symmetric(vertical: 10, horizontal: 20);