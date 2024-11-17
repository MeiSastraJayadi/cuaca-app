import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

// ignore: must_be_immutable
class Indicator extends StatefulWidget {
  String image;
  String value;
  String title;
  Indicator(
      {super.key,
      required this.image,
      required this.value,
      required this.title});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeumorphicText(
          widget.title,
          style: NeumorphicStyle(
            depth: 4, // Positive depth for emboss effect
            color: Colors.white, // Text color
            intensity: 0.6, // Intensity of the lighting
            shadowLightColor: Colors.white.withOpacity(0.5),
            shadowDarkColor: Colors.black.withOpacity(0.5),
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: widget.title != "Kecepatan Angin"
                ? 11
                : 10, // Font size of the text
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Image(
          image: AssetImage(widget.image),
          width: 50,
          height: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        NeumorphicText(
          widget.value,
          style: NeumorphicStyle(
            depth: 4, // Positive depth for emboss effect
            color: Colors.white, // Text color
            intensity: 0.6, // Intensity of the lighting
            shadowLightColor: Colors.white.withOpacity(0.5),
            shadowDarkColor: Colors.black.withOpacity(0.5),
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 15, // Font size of the text
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
