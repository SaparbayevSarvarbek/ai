import 'package:ai/screen/feature/image_generator.dart';
import 'package:ai/screen/feature/introduction.dart';
import 'package:ai/screen/feature/question.dart';
import 'package:ai/screen/feature/translate.dart';
import 'package:ai/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../helper/database_helper.dart';
import '../helper/my_dialog.dart';
import '../helper/pref.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final _isDarkMode = Get.isDarkMode.obs;
  List<Map<String, dynamic>> sections = [];
  late AnimationController _lottieController;
  bool _showAnimation = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _loadSections();
    _lottieController = AnimationController(vsync: this);
  }

  void _startAnimation() {
    setState(() {
      _showAnimation = true;
      MyDialog.info('Suniy intelekt bo\'limida ChatBot ochildi');
    });

    _lottieController.reset();

    if (_lottieController.duration != null) {
      _lottieController.forward().whenComplete(() {
        if (mounted) {
          setState(() {
            _showAnimation =
                false;

          });
        }
      });
    }
  }

  Future<void> _loadSections() async {
    final db = DatabaseHelper.instance;
    final data = await db.getSections();
    setState(() {
      sections = data;
    });
  }

  Future<void> _markAsRead(int id) async {
    final db = DatabaseHelper.instance;
    await db.updateSection(id, 1);
    _loadSections();
  }

  Color _hexToColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.grey; // Default rang
    hex = hex.replaceAll("#", "");
    return Color(int.parse("0xFF$hex"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 10),
              onPressed: () {
                Get.changeThemeMode(
                    _isDarkMode.value ? ThemeMode.light : ThemeMode.dark);

                _isDarkMode.value = !_isDarkMode.value;
                Pref.isDarkMode = _isDarkMode.value;
              },
              icon: Obx(() => Icon(
                  _isDarkMode.value
                      ? Icons.brightness_2_rounded
                      : Icons.brightness_5_rounded,
                  size: 26)))
        ],
      ),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: _showAnimation,
            // Animatsiya ishlayotgan paytda foydalanuvchi ekranga bosolmaydi
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: sections.length,
                    itemBuilder: (context, index) {
                      final section = sections[index];
                      return GestureDetector(
                        onTap: () {
                          Widget page = Introduction();
                          switch (section["id"]) {
                            case 1:
                              page = Introduction();
                              break;
                            case 2:
                              page = Question();
                              break;
                            case 3:
                              page = ImageGenerator();
                              break;
                            case 4:
                              page = Translate();
                              break;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => page),
                          ).then((_) {
                            _markAsRead(section["id"]);
                            _startAnimation();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: _hexToColor(section["color"]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              section["title"] ?? "No Title",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              section["time"] ?? "",
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: section["completed"] == 1
                                ? Icon(Icons.check_circle, color: Colors.white)
                                : Icon(Icons.lock_outline, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_showAnimation)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.8), // Qoraygan fon
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/congratulations.json',
                    controller: _lottieController,
                    repeat: false,
                    fit: BoxFit.cover,
                    onLoaded: (composition) {
                      setState(() {
                        _lottieController.duration = composition.duration;
                      });
                      _lottieController.forward().whenComplete(() {
                        if (mounted) {
                          setState(() {
                            _showAnimation = false;
                          });
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Foydalanuvchi ismi"),
              accountEmail: Text("email@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.blue),
              title: Text('Darslar'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.smart_toy, color: Colors.green),
              title: Text('Sun’iy Intellekt'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Chiqish'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
