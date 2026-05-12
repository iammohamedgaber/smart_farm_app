import 'package:smart_farm_app/core/api/api_service.dart';

import 'package:smart_farm_app/data/models/operation_model.dart';

class OperationsApi {
  final ApiService api = ApiService();

  Future<List<OperationModel>> getOperations() async {
    final data = await api.get(endpoint: "/api/Operations");
    if (data == null) return [];
    if (data is List) {
      return data.map((e) {
        if (e is Map<String, dynamic>) return OperationModel.fromJson(e);
        return OperationModel.fromJson(Map<String, dynamic>.from(e));
      }).toList();
    }
    if (data is Map<String, dynamic>) {
      return [OperationModel.fromJson(data)];
    }
    return [];
  }

  Future<OperationModel?> getOperationById(int id) async {
    final data = await api.get(endpoint: "/api/Operations/$id");
    if (data == null) return null;
    return OperationModel.fromJson(Map<String, dynamic>.from(data));
  }

  

  Future<List<OperationModel>> getAgricultureOperations() async {
    final data = await api.get(endpoint: "/api/Operations/type/agriculture");
    if (data == null) return [];
    return List.from(data)
        .map((e) => OperationModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<List<OperationModel>> getHarvestOperations() async {
    final data = await api.get(endpoint: "/api/Operations/type/harvest");
    if (data == null) return [];
    return List.from(data)
        .map((e) => OperationModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<List<OperationModel>> getRemoveHarmfulOperations() async {
    final data = await api.get(endpoint: "/api/Operations/type/remove-harmful");
    if (data == null) return [];
    return List.from(data)
        .map((e) => OperationModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
