import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';
import 'Repository/Quran-Model/quran-model.dart';

class Telawa extends StatefulWidget {
  final Surah surah;
  const Telawa({super.key, required this.surah});

  @override
  State<Telawa> createState() => _TelawaState();
}

class _TelawaState extends State<Telawa> {
  final _controller = GlobalKey<PageFlipWidgetState>();
  bool isBookmarked = false;

  String toArabicNumbers(int number) {
    const western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const eastern = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((d) => eastern[western.indexOf(d)]).join();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Map<int, List<Ayah>> pagesMap = {};
    for (var ayah in widget.surah.ayahs) {
      pagesMap.putIfAbsent(ayah.page, () => []).add(ayah);
    }
    final pageNumbers = pagesMap.keys.toList()..sort();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF2A6C69)),
          onPressed: (){},
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
              color: const Color(0xFF2A6C69),
            ),
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
            },
          ),
        ],
      ),
      body: PageFlipWidget(
        key: _controller,
        backgroundColor: colors.background,
        isRightSwipe: true,
        lastPage: Container(
          color: colors.background,
          child: const Center(
            child: Text(
              "تمت السورة بحمد الله",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Quran'),
            ),
          ),
        ),
        children: [
          for (var pageNum in pageNumbers)
            _buildMushafPage(pagesMap[pageNum]!, pageNum, pageNumbers.first),
        ],
      ),
    );
  }
  Widget _buildMushafPage(List<Ayah> pageAyahs, int pageNumber, int firstPageInSurah) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      color:colors.background,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF8B7355), width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF2A6C69), width: 3),
            ),
            child: Column(
              children: [
                _buildSurahHeader(widget.surah.name),
                if (pageNumber == firstPageInSurah && widget.surah.number != 9)
                   Padding(
                    padding:const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text("﷽", style: TextStyle(fontSize: 32, fontFamily: 'Quran',color: colors.primary)),
                  ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: SingleChildScrollView(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text.rich(
                          TextSpan(
                            children: pageAyahs.map((ayah) {
                              return WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => _showAyahOptions(context, ayah),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${ayah.text} ",
                                          style:  TextStyle(
                                            fontSize: 23,
                                            fontFamily: 'Quran',
                                            height: 2.0,
                                            color: colors.primary,
                                          ),
                                        ),
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: _buildAyahEnd(ayah.numberInSurah),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    toArabicNumbers(pageNumber),
                    style:  TextStyle(fontSize: 18,  fontWeight: FontWeight.bold,color:colors.primary,)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAyahOptions(BuildContext context, Ayah ayah) {
    final colors = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final colors = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "الآية ${toArabicNumbers(ayah.numberInSurah)}",
                style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color:colors.primary,)
              ),
              const Divider(),
              ListTile(
                //leading: const Icon(Icons.copy, color: Color(0xFF8B7355)),
                title:  Text("تفسير", textAlign: TextAlign.right, style: TextStyle(color: colors.primary)),
                onTap: () {
                  // Add copy logic here
                  Navigator.pop(context);
                },
              ),
              ListTile(
                //leading: const Icon(Icons.share, color: Color(0xFF8B7355)),
                title:  Text("استماع", textAlign: TextAlign.right, style: TextStyle(color: colors.primary)),
                onTap: () {
                  // Add share logic here
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildSurahHeader(String name) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 60, // Fixed height prevents shrinking
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color:  colors.background,
              border: const Border.symmetric(
                horizontal: BorderSide(color: const Color(0xFF8B7355), width: 2),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderSidePattern(),
              _buildHeaderSidePattern(),
            ],
          ),

          // 3. The Text
          Text(
            "سُورَةُ $name",
            textAlign: TextAlign.center,
            style:  TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quran',
                color: colors.primary, // Dark green like the image
                shadows: [
                  Shadow(offset: Offset(0.5, 0.5), color: Colors.black26, blurRadius: 1)
                ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSidePattern() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(
        Icons.brightness_7_outlined,
        color: const Color(0xFFD91602).withOpacity(0.6),
        size: 30,
      ),
    );
  }

  Widget _buildAyahEnd(int number) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
              Icons.brightness_5_rounded,
              color:  Color(0xFF2A6C69),
              size: 32
          ),
          //
          Text(
            toArabicNumbers(number),
            style:  TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: colors.primary
            ),
          ),
        ],
      ),
    );
  }
}