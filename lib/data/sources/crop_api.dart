import 'package:smart_farm_app/core/api/api_service.dart';
import 'package:smart_farm_app/data/models/zone_model.dart';

class CropApi {
  final ApiService api = ApiService();

  
  Future<List<CropModel>> getCrops() async {
    final data = await api.get(endpoint: "/api/crop");

    if (data == null) return [];

    return List.from(data).map((e) => CropModel.fromJson(e)).toList();
  }

 
  Future<CropModel?> getCropById(int cropId) async {
    final data = await api.get(endpoint: "/api/crop/$cropId");

    if (data == null) return null;

    return CropModel.fromJson(Map<String, dynamic>.from(data));
  }
}
