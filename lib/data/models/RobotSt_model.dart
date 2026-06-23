class RobotStatusModel {
  final bool isRunning;
  final String? lastOperation;
  final int? batteryLevel;
  final DateTime? updatedAt;

  RobotStatusModel({
    required this.isRunning,
    this.lastOperation,
    this.batteryLevel,
    this.updatedAt,
  });

  factory RobotStatusModel.fromJson(Map<String, dynamic> json) {
    return RobotStatusModel(
      isRunning: json['isRunning'] ?? false,
      lastOperation: json['lastOperation'],
      batteryLevel: json['batteryLevel'],
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isRunning': isRunning,
      'lastOperation': lastOperation,
      'batteryLevel': batteryLevel,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class OperationsSummaryModel {
  final int totalOperations;
  final int irrigationCount;
  final int plantingCount;
  final int harvestCount;
  final int removeHarmfulCount;

  OperationsSummaryModel({
    required this.totalOperations,
    required this.irrigationCount,
    required this.plantingCount,
    required this.harvestCount,
    required this.removeHarmfulCount,
  });

  factory OperationsSummaryModel.fromJson(Map<String, dynamic> json) {
    return OperationsSummaryModel(
      totalOperations: json['totalOperations'] ?? 0,
      irrigationCount: json['irrigationCount'] ?? 0,
      plantingCount: json['plantingCount'] ?? 0,
      harvestCount: json['harvestCount'] ?? 0,
      removeHarmfulCount: json['removeHarmfulCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalOperations': totalOperations,
      'irrigationCount': irrigationCount,
      'plantingCount': plantingCount,
      'harvestCount': harvestCount,
      'removeHarmfulCount': removeHarmfulCount,
    };
  }
}


class HarvestRequest {
  final int userId;
  final int zoneId;

  HarvestRequest({required this.userId, required this.zoneId});

  Map<String, dynamic> toJson() {
    return {"userId": userId, "zoneId": zoneId};
  }
}

class ScanRequest {
  final int userId;
  final int zoneId;

  ScanRequest({required this.userId, required this.zoneId});

  Map<String, dynamic> toJson() {
    return {"userId": userId, "zoneId": zoneId};
  }
}

class PlantFoundRequest {
  final int plantId;
  final double x;
  final double y;
  final int zoneId;

  PlantFoundRequest({
    required this.plantId,
    required this.x,
    required this.y,
    required this.zoneId,
  });

  Map<String, dynamic> toJson() {
    return {"plantId": plantId, "x": x, "y": y, "zoneId": zoneId};
  }
}
