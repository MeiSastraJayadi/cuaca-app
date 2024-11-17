import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:monitoring/indicator.dart';
import 'package:monitoring/models/data.dart';
import 'package:monitoring/neubox.dart';
import 'package:monitoring/overall.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  DeviceData device;
  MainPage({super.key, required this.device});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 0, longitude: 0),
    initMapWithUserPosition: null,
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  void setLngLat() async {
    double lat = widget.device.lat;
    double lng = widget.device.lng;
    setState(() {
      controller = MapController(
        initPosition: GeoPoint(latitude: lat, longitude: lng),
        initMapWithUserPosition: null,
        areaLimit: BoundingBox(
          east: 0.0003,
          north: 0.0005,
          south: 0.0005,
          west: 0.0003,
        ),
      );
      controller.setMarkerIcon(
          GeoPoint(latitude: lat, longitude: lng),
          const MarkerIcon(
            icon: Icon(
              Icons.location_pin,
              color: Colors.red,
            ),
          ));
    });

    await controller.drawRoadManually([
      await controller.myLocation(),
      GeoPoint(latitude: lat, longitude: lng)
    ], const RoadOption(roadColor: Colors.blue));
  }

  bool scale = false;

  @override
  void initState() {
    super.initState();
    setLngLat();
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: const NeumorphicThemeData(
          baseColor: Color(0xFF28293E), // Slightly lighter dark background
          lightSource: LightSource.topLeft,
          depth: 4,
          intensity: 0.6,
        ),
        home: Scaffold(
          backgroundColor: NeumorphicTheme.baseColor(context),
          body: AnnotatedRegion(
            value: const SystemUiOverlayStyle(
                statusBarColor: Color(0xFF28293E),
                statusBarIconBrightness: Brightness.light),
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFF28293E)),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onScaleUpdate: (ScaleUpdateDetails details) {
                          setState(() {
                            scale = true;
                          });
                        },
                        onScaleEnd: (ScaleEndDetails details) {
                          setState(() {
                            scale = false;
                          });
                        },
                        child: SingleChildScrollView(
                          physics: scale
                              ? const NeverScrollableScrollPhysics()
                              : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 0, 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    NeumorphicButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: NeumorphicStyle(
                                        color: const Color(
                                            0xFF3A3B58), // Button color
                                        depth:
                                            8, // Depth of the button, positive value for emboss effect
                                        intensity:
                                            0.65, // Intensity of the lighting
                                        shape: NeumorphicShape
                                            .concave, // Shape of the button, concave or convex
                                        boxShape:
                                            const NeumorphicBoxShape.circle(),
                                        shadowLightColor:
                                            Colors.white.withOpacity(0.3),
                                        shadowDarkColor:
                                            Colors.black.withOpacity(0.6),
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Icon(
                                        Icons.arrow_back_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NeumorphicBox(
                                    widgets: MainIndicator(
                                      good: widget.device.good,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 55,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: NeumorphicBox(
                                          widgets: Indicator(
                                              image: 'assets/Asset 18@4x 1.png',
                                              value:
                                                  '${widget.device.pressure} Pa',
                                              title: 'Tekanan Udara'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 46,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: NeumorphicBox(
                                          widgets: Indicator(
                                              image: 'assets/Thermometer.png',
                                              value: '${widget.device.temp}°C',
                                              title: 'Suhu'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      flex: 47,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: NeumorphicBox(
                                          widgets: Indicator(
                                              image: 'assets/Asset 12@4x 1.png',
                                              value:
                                                  '${widget.device.humidity}%',
                                              title: 'Kelembapan'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 53,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: NeumorphicBox(
                                          widgets: Indicator(
                                              image: 'assets/Asset 16@4x 1.png',
                                              value: '${widget.device.acc} m/s',
                                              title: 'Kecepatan Angin'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        height: 400,
                                        child: OSMFlutter(
                                          controller: controller,
                                          osmOption: OSMOption(
                                            showZoomController: true,
                                            staticPoints: [
                                              StaticPositionGeoPoint(
                                                  '1',
                                                  const MarkerIcon(
                                                      icon: Icon(
                                                    Icons.location_pin,
                                                    color: Colors.red,
                                                    size: 30,
                                                  )),
                                                  [
                                                    GeoPoint(
                                                        latitude:
                                                            widget.device.lat,
                                                        longitude:
                                                            widget.device.lng)
                                                  ])
                                            ],
                                            userLocationMarker:
                                                UserLocationMaker(
                                              personMarker: const MarkerIcon(
                                                icon: Icon(
                                                  Icons
                                                      .location_history_rounded,
                                                  color: Colors.red,
                                                  size: 48,
                                                ),
                                              ),
                                              directionArrowMarker:
                                                  const MarkerIcon(
                                                icon: Icon(
                                                  Icons.double_arrow,
                                                  size: 48,
                                                ),
                                              ),
                                            ),
                                            roadConfiguration: const RoadOption(
                                              roadColor: Colors.yellowAccent,
                                            ),
                                            zoomOption:
                                                const ZoomOption(initZoom: 14),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
