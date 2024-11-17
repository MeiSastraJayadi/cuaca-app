import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

// ignore: must_be_immutable
class NeumorphicBox extends StatefulWidget {
  Widget widgets;
  NeumorphicBox({super.key, required this.widgets});

  @override
  State<NeumorphicBox> createState() => _NeumorphicBoxState();
}

class _NeumorphicBoxState extends State<NeumorphicBox> {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.only(left: 3, right: 3, top: 2, bottom: 4),
      style: NeumorphicStyle(
        color: const Color(0xFF313149), // Neumorphic container color
        depth: -5, // Negative depth for inset effect
        intensity: 0.4,
        shape: NeumorphicShape.flat,
        shadowLightColor: Colors.white.withOpacity(0.1),
        shadowDarkColor: Colors.black.withOpacity(0.5),
        boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.all(Radius.circular(20))),
      ),
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: widget.widgets,
      ),
    );
  }
}
