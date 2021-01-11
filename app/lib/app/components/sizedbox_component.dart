import 'package:flutter/cupertino.dart';

Widget sizedBoxComponent({Widget child, double height, double width}) {
  return SizedBox(
    width: width,
    height: height,
    child: child,
  );
}
