import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:monitoring/models/data.dart';
import 'package:monitoring/neubox.dart';
import 'package:monitoring/page.dart';
import 'package:monitoring/routing.dart';

// ignore: must_be_immutable
class NeuCard extends StatelessWidget {
  bool good;
  double temp;
  DeviceData device;
  NeuCard(
      {super.key,
      required this.good,
      required this.temp,
      required this.device});

  String formatTime() {
    initializeDateFormatting('id_ID', null);
    return DateFormat('d MMMM yyyy H:mm:ss', 'id_ID').format(device.date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: NeumorphicButton(
        onPressed: () {
          Navigator.of(context).push(getRoute(MainPage(
            device: device,
          )));
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
        child: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(good ? 'assets/Sun.png' : 'assets/Thunder.png'),
              width: 40,
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(good ? 'Cuaca Baik' : 'Cuaca Buruk',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(formatTime(),
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
            Text('$temp°C',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          ],
        )),
      ),
    );
  }
}
