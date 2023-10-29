import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SolarIcons {
  static Widget getOutline(String name) {
    return Container(
      color: Colors.transparent,
      width: 24,
      height: 24,
      child: SvgPicture.asset(
        "assets/icons/Solar/Outline/$name.svg",
      ),
    );
  }

  static Widget getOutlineWithSize(String name, double size) {
    return Container(
      color: Colors.transparent,
      width: size,
      height: size,
      child: SvgPicture.asset(
        "assets/icons/Solar/Outline/$name.svg",
      ),
    );
  }

  static Widget getBold(String name) {
    return SizedBox(
      width: 24,
      height: 24,
      child: SvgPicture.asset(
        "assets/icons/Solar/Bold/$name.svg",
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.lighten),
      ),
    );
  }
}

enum SolarIconType {
  Bold,
  BoldDuotone,
  Broken,
  LineDuotone,
  Linear,
  Outline
}