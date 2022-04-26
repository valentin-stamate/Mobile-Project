import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon extends StatelessWidget {
  final String _path;

  const AppIcon(this._path);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _path,
      width: 24,
      height: 24,
      color: Colors.white,
    );
  }

}