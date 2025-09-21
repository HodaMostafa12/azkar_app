import 'package:azkar_app/view/Quran/recitation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/appbar.dart';
import 'View_model/viewmodel.dart';

class Quran extends StatelessWidget {
  const Quran({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (context) => SurahViewModel()..fetchSurahs(),
      child: Scaffold(
        appBar: const CustomAppBar(title: "المصحف", showBackButton: true),
        body: Consumer<SurahViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text(viewModel.errorMessage));
            }

            return Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/Quran.png",
                    height: 200,
                    width: 365,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: viewModel.surahs.length,
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: const Divider(
                        color: Colors.teal,
                        thickness: 1,
                        height: 1,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final surah = viewModel.surahs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Telawa(surah: surah), // pass actual Surah
                            ),
                          );

                        },
                        child: ListTile(
                          leading: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/islamic-architecture.png',
                                width: 40,
                                height: 40,
                              ),
                              Text(
                                surah.number.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  surah.englishName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  surah.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${surah.revelationType.name}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(" - "),
                              Text(
                                "${surah.ayahs.length} Ayahs",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
