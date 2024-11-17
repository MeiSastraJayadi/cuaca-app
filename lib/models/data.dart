class Data {
  bool good;
  double temp;
  Data({required this.good, required this.temp});
}

class DeviceData {
  int id;
  double lat;
  double lng;
  double temp;
  double acc;
  double pressure;
  double humidity;
  DateTime date;
  bool good;

  DeviceData(
      {required this.id,
      required this.lat,
      required this.lng,
      required this.temp,
      required this.acc,
      required this.pressure,
      required this.humidity,
      required this.date,
      required this.good});
}
