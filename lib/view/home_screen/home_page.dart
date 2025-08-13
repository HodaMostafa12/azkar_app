import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  final List<String> options=["الاذكار","مواقيت الصلاة","المصحف","المصحف","القبلة","المهام اليومية"];
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
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF152D45),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => const DailyVersePage()),
                          // );
                        },
                        child: const Text(
                          "سورة البقرة، آية 100\n"
                              "أَوَكُلَّمَا عَاهَدُوا عَهْدًا نَّبَذَهُ فَرِيقٌ مِّنْهُم...",
                          style: TextStyle(color: Colors.white,fontSize:18 ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(

                        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFCB3526),),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => const DailyVersePage()),
                          // );
                        },
                      ),
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
                height: 220,
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

                        Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFCB3526),),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (_) => const TaskDetailsPage()),
                              // );
                            },
                          ),
                        ),

                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "الانشطة",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFFCB3526),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.right,
              ),
          const SizedBox(height: 10,),
              SizedBox(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                      shrinkWrap: true,
                      itemCount: options.length,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.5,
                          crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 16),
                      itemBuilder: (context,index){
                        return SizedBox(
                          child: Card(
                            color: const Color(0xFF152D45),
                            child: Center(child: Text(options[index],style: TextStyle(fontFamily: "B Fantezy",color: Colors.white,fontSize: 30),)),
                          ),
                        );
                      }

                  )
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 4),
        child:

    ClipRRect(
    borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
    ),
    child:
        BottomNavigationBar(

          type: BottomNavigationBarType.fixed, // Needed for backgroundColor to work
          currentIndex: _selectedIndex,
          onTap: _onNavTap,
          selectedItemColor: const Color(0xFFCB3526),
          unselectedItemColor: Colors.grey,
          backgroundColor: const Color(0xFF152D45),
          items: [
            _buildNavItem("assets/icons/settings.svg", "الإعدادات", 0),
            _buildNavItem("assets/icons/fav.svg", "المفضلة", 1),
            _buildNavItem("assets/icons/home.svg", "الرئيسية", 2),
            _buildNavItem("assets/icons/seb7a.svg", "السبحه الالكترونية", 3),
          ],
        ),
      ),
      )
    );
  }


  BottomNavigationBarItem _buildNavItem(String assetPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          _selectedIndex == index ? const Color(0xFFCB3526) : Colors.grey,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }



  // Right-aligned checkbox + text
  Widget _buildTaskItem(String title, int index) {
    //     ),
    return    Row(
      mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            Checkbox(
              value: _tasks[index],
              onChanged: (val) {
                setState(() {
                  _tasks[index] = val ?? false;
                });
              },
              checkColor: Colors.black, // Tick color
              fillColor: MaterialStateProperty.all(Colors.white), // Background fill color
              activeColor: const Color(0xFFCB3526), // Outline color when active
            )
          ],

    );
  }
}


