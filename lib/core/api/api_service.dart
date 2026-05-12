import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://nonchivalrous-jacinda-illustratively.ngrok-free.dev";

  Future<dynamic> get({required String endpoint, String? token}) async {
    final url = Uri.parse("$baseUrl$endpoint");

    print("GET URL: $url");

    Map<String, String> headers = {};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(url, headers: headers);

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (_) {
        return response.body;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");

    print("POST URL: $url");

    Map<String, String> headers = {"Content-Type": "application/json"};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (_) {
        return response.body;
      }
    } else {
      return null;
    }
  }

  // DELETE method (paste inside your ApiService)
  Future<bool> delete({required String endpoint, String? token}) async {
    final url = Uri.parse("$baseUrl$endpoint");

    print("DELETE URL: $url");

    Map<String, String> headers = {};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.delete(url, headers: headers);

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    // consider 200, 201, 204 as success
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
