import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget iconComponent(
    {@required IconData icon,
    Color color,
    EdgeInsets padding,
    Alignment alignment,
    Function() function}) {
  return InkWell(
    child: Container(
      alignment: alignment,
      padding: padding,
      child: Icon(
        icon,
        size: 20,
        color: color,
      ),
    ),
    onTap: function,
  );
}
