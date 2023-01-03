import 'package:flutter/cupertino.dart';

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    // path.lineTo(0, height - 50);
    // path.quadraticBezierTo(width / 2, height, width, height - 50);
    // path.lineTo(width, 0);
    // path.close();
    // Path path_0 = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height * 0.9649123);
    path.cubicTo(width * 1.022864, height * 1.131246, width * 0.4294139,
        height * 0.6160921, 0, height * 0.9649123);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
