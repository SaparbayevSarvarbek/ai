import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'apis/app_write.dart';
import 'helper/ad_helper.dart';
import 'helper/database_helper.dart';
import 'helper/global.dart';
import 'helper/pref.dart';
import 'screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await Pref.initialize();
  await _insertInitialData();
  // for app write initialization
  AppWrite.init();

  // for initializing facebook ads sdk
  AdHelper.init();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

Future<void> _insertInitialData() async {
  final db = DatabaseHelper.instance;
  List<Map<String, dynamic>> sections = await db.getSections();

  if (sections.isEmpty) {
    await db.addSection({"title": "ChatGPT haqida", "time": "7 min", "completed": 0, "color": "#6A5ACD"}); // Purple
    await db.addSection({"title": "Sovol so'rash", "time": "5 min", "completed": 0, "color": "#DC143C"}); // Red
    await db.addSection({"title": "Rasmlar yaratish", "time": "7 min", "completed": 0, "color": "#8A2BE2"}); // Blue-Violet
    await db.addSection({"title": "Matnlarni tarjima qilish", "time": "7 min", "completed": 0, "color": "#DAA520"}); // Goldenrod
    await db.addSection({"title": "Prompting Techniques", "time": "5 min", "completed": 0, "color": "#228B22"}); // Green
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,

      themeMode: Pref.defaultTheme,

      //dark
      darkTheme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            elevation: 1,
            centerTitle: true,
            titleTextStyle:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )),

      //light
      theme: ThemeData(
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
            elevation: 1,
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.blue),
            titleTextStyle: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w500),
          )),

      //
      home: const SplashScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  //light text color
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;

  //button color
  Color get buttonColor =>
      brightness == Brightness.dark ? Colors.cyan.withOpacity(.5) : Colors.blue;
}