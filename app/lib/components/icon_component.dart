import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget iconComponent(
    {@required IconData icon, Color color, Function() function}) {
  return InkWell(
    child: Icon(
      icon,
      size: 20,
      color: color,
    ),
    onTap: function,
  );
}
