import 'package:flutter/material.dart';
import '../Repository/Quran-Model/quran-model.dart';
import '../Repository/quran-repo.dart';

class SurahViewModel extends ChangeNotifier {
  final SurahRepository _repository = SurahRepository();

  List<Surah> _surahs = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Edition? _edition;

  List<Surah> get surahs => _surahs;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Edition? get edition => _edition;

  Future<void> fetchSurahs() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _surahs = await _repository.fetchSurahs();

      printSurahs();

    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void printSurahs() {
    for (var surah in _surahs) {
      print("Surah ${surah.number}: ${surah.name} (${surah.englishName})");
    }
  }
}
