import 'dart:convert';
import 'package:http/http.dart' as http;
import 'azkar_model/azkar_model.dart';

class AzkarRepository {
  final String baseUrl = "https://mocki.io/v1/8d66c3d0-11f6-46e6-94ea-ddbdc9b9661f";

  Future<List<AzkarModel>> fetchAzkar() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // 👇 نفك التشفير بالطريقة الصح
      final decoded = utf8.decode(response.bodyBytes);

      print("Raw Response UTF8: $decoded");

      List data = jsonDecode(decoded);
      print("Decoded Data: $data");

      return data.map((e) => AzkarModel.fromJson(e)).toList();
    } else {
      print("Error Response: ${response.statusCode} - ${response.body}");
      throw Exception("Failed to load Azkar");
    }
  }
}
