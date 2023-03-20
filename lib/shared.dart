//this class will store all the values that gonna be used for the whole app

import 'package:flutter/material.dart';

extension ToColor on Color {
  static Color fromHex(String oldColor) {
    Color newColor = Color(int.parse('ff${oldColor.substring(1)}', radix: 16));
    return newColor;
  }
}
