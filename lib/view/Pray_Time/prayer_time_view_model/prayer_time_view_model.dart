// viewmodel/prayer_time_viewmodel.dart
import 'package:flutter/material.dart';
import '../repository/model/prayer_time_model.dart';
import '../repository/prayer_time_repo.dart';

class PrayerTimeViewModel extends ChangeNotifier {
  final PrayerTimeRepository _repo = PrayerTimeRepository();

  List<PrayerTimeModel> _prayerTimes = [];
  List<PrayerTimeModel> get prayerTimes => _prayerTimes;

  DateTime? _date;
  DateTime? get date => _date;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> loadPrayerTimes(double lat, double lng, [DateTime? date]) async {
    _loading = true;
    notifyListeners();

    final result = await _repo.getPrayerTimes(lat, lng, date);
    _prayerTimes = result["times"] as List<PrayerTimeModel>;
    _date = result["date"] as DateTime; // ✅ دلوقتي شغال

    _loading = false;
    notifyListeners();
  }

}
