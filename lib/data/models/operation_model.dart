class OperationModel {
  final int operationId;
  final int operationType;
  final int userId;
  final int zoneId;
  final int? cropId;
  final int? harmfulPlantId;
  final int? duration;
  final DateTime createdAt;

  OperationModel({
    required this.operationId,
    required this.operationType,
    required this.userId,
    required this.zoneId,
    this.cropId,
    this.harmfulPlantId,
    this.duration,
    required this.createdAt,
  });

  factory OperationModel.fromJson(Map<String, dynamic> json) {
    return OperationModel(
      operationId: json['operationId'] ?? 0,
      operationType: json['operationType'] ?? 0,
      userId: json['userId'] ?? 0,
      zoneId: json['zoneId'] ?? 0,
      cropId: json['cropId'],
      harmfulPlantId: json['harmfulPlantId'],
      duration: json['duration'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'operationId': operationId,
      'operationType': operationType,
      'userId': userId,
      'zoneId': zoneId,
      'cropId': cropId,
      'harmfulPlantId': harmfulPlantId,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
