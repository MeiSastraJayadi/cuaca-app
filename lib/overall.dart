import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

// ignore: must_be_immutable
class MainIndicator extends StatefulWidget {
  bool good;
  MainIndicator({super.key, required this.good});

  @override
  State<MainIndicator> createState() => _MainIndicatorState();
}

class _MainIndicatorState extends State<MainIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeumorphicText(
          'Kondisi Cuaca',
          style: NeumorphicStyle(
            depth: 4, // Positive depth for emboss effect
            color: Colors.white, // Text color
            intensity: 0.6, // Intensity of the lighting
            shadowLightColor: Colors.white.withOpacity(0.5),
            shadowDarkColor: Colors.black.withOpacity(0.5),
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 18, // Font size of the text
            fontWeight: FontWeight.w500,
          ),
        ),
        Image(
          image: widget.good
              ? const AssetImage('assets/Sun.png')
              : const AssetImage('assets/Thunder.png'),
          width: 100,
          height: 100,
        ),
        NeumorphicText(
          widget.good ? 'Bagus' : 'Buruk',
          style: NeumorphicStyle(
            depth: 4, // Positive depth for emboss effect
            color: Colors.white, // Text color
            intensity: 0.6, // Intensity of the lighting
            shadowLightColor: Colors.white.withOpacity(0.5),
            shadowDarkColor: Colors.black.withOpacity(0.5),
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 20, // Font size of the text
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
