import 'package:flutter/material.dart';
//import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class CustomIcon extends StatelessWidget {
  final dynamic iconData;

  final Color? color;

  final double? size;
  const CustomIcon(
    this.iconData, {
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (iconData.runtimeType == IconData) {
      return Icon(
        iconData as IconData,
        size: size,
        color: color,
      );
    } /* else if (iconData.runtimeType == ResponsiveSvgIconData) {
       
        return SvgIcon(
            icon: iconData as ResponsiveSvgIconData, size: size, color: color);
      } */
    else {
      return Icon(
        iconData as IconData,
        size: size,
        color: color,
      );
      /* throw Exception("Unsupported Icontype."
          " Use either IconData or ResponsiveSvgIconData ${iconData.runtimeType}"); */
    }
  }
}
