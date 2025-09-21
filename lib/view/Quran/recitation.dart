import 'package:flutter/material.dart';
import '../../utils/appbar.dart';
import 'Repository/Quran-Model/quran-model.dart';

class Telawa extends StatelessWidget {
  final Surah surah; // <-- take Surah as parameter

  const Telawa({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: const CustomAppBar(title: "التلاوة", showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Surah name inside a styled box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.tealAccent, width: 2),
              ),
              child: Center(
                child: Text(
                  surah.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Basmala (not in Surah At-Tawbah)
            if (surah.number != 9)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),

              ),

            const SizedBox(height: 10),

            // Ayahs
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: surah.ayahs.map((ayah) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "${ayah.text} (${ayah.numberInSurah})",
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.8,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
