import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  final List<String> options = ["الاذكار", "مواقيت الصلاة", "المصحف", "المصحف", "القبلة", "المهام اليومية"];
  final List<bool> _tasks = [false, false, false, false, false];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme; // الألوان من الثيم
    final textTheme = Theme.of(context).textTheme; // النصوص من الثيم

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: colors.background,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 26,
            backgroundColor: colors.primary,
            child: Text(
              "R",
              style: textTheme.bodyLarge?.copyWith(color: colors.onPrimary),
            ),
          ),
        ),
        title: SizedBox(
          height: 80,
          width: 140,
          child: SvgPicture.asset(
            "assets/icons/fzkrAppBar.svg",
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Text(
                "الورد اليومى",
                style: textTheme.titleMedium?.copyWith(
                  color: colors.error,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),

              // First container
              Container(
                padding: const EdgeInsets.all(16),
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colors.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "سورة البقرة، آية 100\n"
                          "أَوَكُلَّمَا عَاهَدُوا عَهْدًا نَّبَذَهُ فَرِيقٌ مِّنْهُم...",
                          style: textTheme.bodyMedium?.copyWith(color: colors.onPrimary),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: colors.error),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Text(
                "المهام اليومية",
                style: textTheme.titleMedium?.copyWith(
                  color: colors.error,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),

              // Second container
              Container(
                height: 220,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colors.secondary,
                ),
                child: Column(
                  children: [
                    _buildTaskItem("أذكار الصباح", 0, colors, textTheme),
                    _buildTaskItem("الورد اليومى", 1, colors, textTheme),
                    _buildTaskItem("أذكار المساء", 2, colors, textTheme),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: colors.error),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Text(
                "الانشطة",
                style: textTheme.titleMedium?.copyWith(
                  color: colors.error,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 1000,
                child: GridView.builder(
                  itemCount: options.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          options[index],
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.onPrimary,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        selectedItemColor: colors.error,
        unselectedItemColor: Colors.grey,
        backgroundColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "الإعدادات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "المفضلة",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: "الدروس",
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, int index, ColorScheme colors, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: textTheme.bodyMedium?.copyWith(color: colors.onSecondary)),
        Checkbox(
          value: _tasks[index],
          onChanged: (val) {
            setState(() {
              _tasks[index] = val ?? false;
            });
          },
          activeColor: Theme.of(context).colorScheme.error,
        ),
      ],
    );
  }
}
