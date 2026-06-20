import 'package:intl/intl.dart';

class SensorModel {
  final int sensorId;
  final double airTemperature;
  final double airHumidity;
  final double soilMoisture;
  final DateTime recordedAt;

  SensorModel({
    required this.sensorId,
    required this.airTemperature,
    required this.airHumidity,
    required this.soilMoisture,
    required this.recordedAt,
  });

  /// ✅ تحويل من JSON إلى Object
  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      sensorId: (json["sensorId"] ?? 0) as int,
      airTemperature: (json["airTemperature"] ?? 0).toDouble(),
      airHumidity: (json["airHumidity"] ?? 0).toDouble(),
      soilMoisture: (json["soilMoisture"] ?? 0).toDouble(),
      recordedAt: DateTime.tryParse(json["recordedAt"] ?? "") ?? DateTime.now(),
    );
  }

  /// ✅ تحويل من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      "sensorId": sensorId,
      "airTemperature": airTemperature,
      "airHumidity": airHumidity,
      "soilMoisture": soilMoisture,
      "recordedAt": recordedAt.toIso8601String(), // تحويل التاريخ إلى String
    };
  }

  /// ✅ Getter لعرض التاريخ بشكل منسق في الـ UI
  String get formattedDate {
    return DateFormat("dd/MM/yyyy HH:mm").format(recordedAt);
  }
}

class AllSensorsModel {
  final List<SensorModel> sensors;

  AllSensorsModel({required this.sensors});

  /// ✅ تحويل من JSON List إلى Object
  factory AllSensorsModel.fromJson(List<dynamic> jsonList) {
    return AllSensorsModel(
      sensors: jsonList.map((e) => SensorModel.fromJson(e)).toList(),
    );
  }

  /// ✅ تحويل من Object إلى JSON List
  List<Map<String, dynamic>> toJson() {
    return sensors.map((e) => e.toJson()).toList();
  }
}
