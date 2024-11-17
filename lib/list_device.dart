import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:http/http.dart';
import 'package:monitoring/models/data.dart';
import 'package:monitoring/neucard.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({super.key});

  @override
  State<ListHistory> createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  List<Data> data = [
    Data(good: true, temp: 27),
    Data(good: true, temp: 27),
    Data(good: false, temp: 27),
    Data(good: true, temp: 27),
    Data(good: true, temp: 27),
    Data(good: false, temp: 27),
    Data(good: true, temp: 27),
    Data(good: true, temp: 27)
  ];

  List<DeviceData> itm = [];

  List<DeviceData> items = [];

  bool loading = false;
  bool stillFetch = false;
  String? next;
  int page = 1;

  Future<void> getData() async {
    setState(() {
      stillFetch = true;
    });

    Response response =
        await get(Uri.parse('http://103.171.85.186/api/device?page=$page'));

    if (response.statusCode == 200) {
      Map body = jsonDecode(response.body);
      List logs = body["data"];

      for (Map item in logs) {
        int id = item["machine_id"];
        double lat = double.parse(item['lat']);
        double lng = double.parse(item['lng']);
        double temp = item['suhu'].toDouble();
        double acc = item['kecepatan_angin'].toDouble();
        double pressure = item['tekanan_udara'].toDouble();
        double humidity = item['kelembaban'].toDouble();
        bool good = item['kondisi_baik'] > 0 ? true : false;
        String tm = item['created_at'].toString();
        DateTime time = DateTime.parse(tm).add(const Duration(hours: 8));

        DeviceData dt = DeviceData(
            id: id,
            lat: lat,
            lng: lng,
            temp: temp,
            acc: acc,
            pressure: pressure,
            date: time,
            humidity: humidity,
            good: good);
        setState(() {
          items.add(dt);
        });
      }

      setState(() {
        next = body["next_page_url"];
        page++;
      });
    }
    setState(() {
      stillFetch = false;
    });
  }

  Future<void> initFetch() async {
    setState(() {
      loading = true;
      next = null;
      page = 1;
      items.clear();
    });
    await getData();
    setState(() {
      loading = false;
    });
  }

  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    initFetch();
    controller.addListener(() {
      if ((controller.position.atEdge)) {
        if ((controller.position.pixels != 0) &&
            (next != null) &&
            !stillFetch) {
          getData();
        }
      }
    });
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
          appBar: AppBar(
            title: const Text('Riwayat'),
          ),
          body: AnnotatedRegion(
            value: const SystemUiOverlayStyle(
                statusBarColor: Color(0xFF28293E),
                statusBarIconBrightness: Brightness.light),
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFF28293E)),
              child: SafeArea(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: initFetch,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: items.isEmpty
                              ? const Center(child: Text('Tidak ada data log'))
                              : ListView.builder(
                                  controller: controller,
                                  itemCount: items.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < items.length) {
                                      return NeuCard(
                                        good: items[index].good,
                                        temp: items[index].temp,
                                        device: items[index],
                                      );
                                    } else {
                                      if (next != null) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      } else {
                                        return const SizedBox(
                                          width: 0,
                                        );
                                      }
                                    }
                                  },
                                ),
                        ),
                      ),
              ),
            ),
          ),
        ));
  }
}
