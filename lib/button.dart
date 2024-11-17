import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class NeuButton extends StatefulWidget {
  const NeuButton({super.key});

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () {
        print("Neumorphic Button Pressed");
      },
      style: NeumorphicStyle(
        color: const Color(0xFF3A3B58), // Button color
        depth: 8, // Depth of the button, positive value for emboss effect
        intensity: 0.65, // Intensity of the lighting
        shape:
            NeumorphicShape.concave, // Shape of the button, concave or convex
        shadowLightColor: Colors.white.withOpacity(0.3),
        shadowDarkColor: Colors.black.withOpacity(0.6),
      ),
      padding: const EdgeInsets.all(20.0),
      child: const Text(
        "Sinkronkan",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
