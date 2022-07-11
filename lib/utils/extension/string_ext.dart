import 'package:flutter/material.dart';
import 'package:todo_list_project/utils/extension/color_ext.dart';

extension StringColor on String {
  Color get hexColor {
    return HexColor.fromHex(this);
  }
}
