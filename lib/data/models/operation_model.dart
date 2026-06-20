class OperationModel {
  final int operationId;
  final int operationType; // ✅ النوع (0 زراعة، 1 حصاد، 2 إزالة، 3 ري)
  final int userId;
  final int zoneId;
  final int? cropId;
  final String? cropName;
  final int? harmfulPlantId;
  final int? duration; // ✅ مدة العملية (تستخدم في الري غالبًا)
  final DateTime createdAt;

  OperationModel({
    required this.operationId,
    required this.operationType,
    required this.userId,
    required this.zoneId,
    this.cropId,
    this.cropName,
    this.harmfulPlantId,
    this.duration,
    required this.createdAt,
  });

  factory OperationModel.fromJson(Map<String, dynamic> json) {
    // ✅ نحول النص اللي جاي من الـ API لرقم
    int type = 0;
    switch (json['operationTypeName']) {
      case 'Planting':
        type = 0;
        break;
      case 'Harvest':
        type = 1;
        break;
      case 'Remove Harmful Plant':
        type = 2;
        break;
      case 'Irrigation':
        type = 3;
        break;
      default:
        type = 0;
    }

    return OperationModel(
      operationId: json['operationId'] ?? 0,
      operationType: type, // ✅ النوع مظبوط دلوقتي
      userId: 0, // مش محتاجينه في الـ UI
      zoneId: json['zoneId'] ?? 0,
      cropId: json['cropId'],
      cropName: json['cropName'],
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
      'cropName': cropName,
      'harmfulPlantId': harmfulPlantId,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
