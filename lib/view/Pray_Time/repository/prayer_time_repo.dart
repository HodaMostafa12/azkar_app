import 'package:adhan/adhan.dart';

import 'model/prayer_time_model.dart';

class PrayerTimeRepository {
  Future<Map<String, dynamic>> getPrayerTimes(double lat, double lng, [DateTime? date]) async {
    final coordinates = Coordinates(lat, lng);
    final params = CalculationMethod.egyptian.getParameters();
    final selectedDate = date ?? DateTime.now();

    final dateComponents = DateComponents.from(selectedDate);
    final prayerTimes = PrayerTimes(coordinates, dateComponents, params);

    final List<PrayerTimeModel> times = [
      PrayerTimeModel("الفجر", prayerTimes.fajr),
      PrayerTimeModel("الشروق", prayerTimes.sunrise),
      PrayerTimeModel("الظهر", prayerTimes.dhuhr),
      PrayerTimeModel("العصر", prayerTimes.asr),
      PrayerTimeModel("المغرب", prayerTimes.maghrib),
      PrayerTimeModel("العشاء", prayerTimes.isha),
    ];

    return {
      "times": times,
      "date": selectedDate, // ✅ استخدمنا التاريخ اللي مررناه
    };
  }
}
