import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<bool> _tasks = [false, false, false, false, false];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E0D0),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xFFE7E0D0),
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFF162F43),
            child: const Text("R", style: TextStyle(color: Colors.white)),
          ),
        ),
        title: SizedBox(
          height: 80,
          width: 140,
          child: SvgPicture.asset(
            "assets/images/fzkrAppBar.svg",
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
              const Text(
                "الورد اليومى",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFFCB3526),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),

              // First container with arrow
              Container(
                padding: const EdgeInsets.all(16),
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF152D45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const DailyVersePage()),
                          );
                        },
                        child: const Text(
                          "سورة البقرة، آية 100\n"
                              "أَوَكُلَّمَا عَاهَدُوا عَهْدًا نَّبَذَهُ فَرِيقٌ مِّنْهُم...",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DailyVersePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "المهام اليومية",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFFCB3526),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),

              // Second container with arrow
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF155F5E),
                ),
                child: Column(
                  children: [
                    _buildTaskItem("أذكار الصباح", 0),
                    _buildTaskItem("الورد اليومى", 1),
                    _buildTaskItem("أذكار المساء", 2),
                    _buildTaskItem("صدقة", 3),
                    _buildTaskItem("الصلاة", 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        selectedItemColor: const Color(0xFFCB3526),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF152D45),
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

  // Right-aligned checkbox + text
  Widget _buildTaskItem(String title, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TaskDetailsPage()),
            );
          },
        ),
        Row(
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            Checkbox(
              value: _tasks[index],
              onChanged: (val) {
                setState(() {
                  _tasks[index] = val ?? false;
                });
              },
              activeColor: const Color(0xFFCB3526),
            ),
          ],
        ),
      ],
    );
  }
}

class DailyVersePage extends StatelessWidget {
  const DailyVersePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E0D0),
      appBar: AppBar(
        title: const Text("الورد اليومى"),
        backgroundColor: const Color(0xFF152D45),
      ),
      body: const Center(
        child: Text(
          "هنا تفاصيل الورد اليومى",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تفاصيل المهمة")),
      body: const Center(child: Text("صفحة تفاصيل المهمة")),
    );
  }
}
