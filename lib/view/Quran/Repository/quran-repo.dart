import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Quran-Model/quran-model.dart'; // Adjust the path if needed

class SurahRepository {
  final String apiUrl = 'https://api.alquran.cloud/v1/quran/quran-uthmani';

  Future<List<Surah>> fetchSurahs() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final quranModel = quranModelFromJson(response.body);
      return quranModel.data.surahs;
    } else {
      throw Exception('Failed to load surahs');
    }
  }
}
