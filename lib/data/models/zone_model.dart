class ZoneModel {
  final int zoneId;
  final int cropId;
  final String? lastIrrigation;

  ZoneModel({required this.zoneId, required this.cropId, this.lastIrrigation});

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      zoneId: (json["zoneId"] ?? 0) as int,
      cropId: (json["cropId"] ?? 0) as int,
      lastIrrigation: json["lastIrrigation"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "zoneId": zoneId,
      "cropId": cropId,
      "lastIrrigation": lastIrrigation,
    };
  }
}

class CropModel {
  final int id;
  final String name;

  CropModel({required this.id, required this.name});

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      id: (json["cropId"] ?? json["id"] ?? 0) as int,
      name: (json["cropName"] ?? json["name"] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {"cropId": id, "cropName": name};
  }
}

class PlantCropRequest {
  final int cropId;
  final int userId;
  final int zoneId;

  PlantCropRequest({
    required this.cropId,
    required this.userId,
    required this.zoneId,
  });

  Map<String, dynamic> toJson() {
    return {"cropId": cropId, "userId": userId, "zoneId": zoneId};
  }
}

class AddHarmfulPlantRequest {
  final int plantId;
  final double x;
  final double y;
  final int userId;
  final int zoneId;

  AddHarmfulPlantRequest({
    required this.plantId,
    required this.x,
    required this.y,
    required this.userId,
    required this.zoneId,
  });

  Map<String, dynamic> toJson() {
    return {
      "plantId": plantId,
      "x": x,
      "y": y,
      "userId": userId,
      "zoneId": zoneId,
    };
  }
}

class RemoveHarmfulPlantRequest {
  final int plantId;
  final double x;
  final double y;
  final int userId;
  final int zoneId;

  RemoveHarmfulPlantRequest({
    required this.plantId,
    required this.x,
    required this.y,
    required this.userId,
    required this.zoneId,
  });

  Map<String, dynamic> toJson() {
    return {
      "plantId": plantId,
      "x": x,
      "y": y,
      "userId": userId,
      "zoneId": zoneId,
    };
  }
}

class IrrigateRequest {
  final int userId;
  final int zoneId;
  final int duration;

  IrrigateRequest({
    required this.userId,
    required this.zoneId,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {"userId": userId, "zoneId": zoneId, "duration": duration};
  }
}
