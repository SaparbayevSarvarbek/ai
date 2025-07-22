
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  List<bool> expandedList = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savol so'rash"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroSection().animate().fadeIn(duration: 800.ms),
            SizedBox(height: 20),
            _buildGuidelinesSection().animate().slideX(duration: 600.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.teal[800],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.robot,
                    color: Colors.orangeAccent, size: 28),
                SizedBox(width: 10),
                Text("ChatGPT nima qila oladi?",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            SizedBox(height: 10),
            _buildCapabilityItem(
                "Savollarga javob beradi", FontAwesomeIcons.question),
            _buildCapabilityItem(
                "Kod yozishga yordam beradi", FontAwesomeIcons.laptopCode),
            _buildCapabilityItem("Matn tahrirlash va yaxshilash",
                FontAwesomeIcons.fileSignature),
            _buildCapabilityItem("Mavzular bo'yicha maslahat berish",
                FontAwesomeIcons.commentDots),
            _buildCapabilityItem(
                "Reja va g'oyalar yaratish", FontAwesomeIcons.lightbulb),
            _buildCapabilityItem(
                "Tarjimon vazifasini bajarish", FontAwesomeIcons.language),
            _buildCapabilityItem(
                "Yozuv uslubini optimallashtirish", FontAwesomeIcons.penNib),
          ],
        ),
      ),
    );
  }

  Widget _buildCapabilityItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orangeAccent),
          SizedBox(width: 8),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    ).animate().fade(duration: 500.ms);
  }

  Widget _buildGuidelinesSection() {
    List<String> tips = [
      "Aniq va tushunarli bo'ling",
      "Kontekst qo'shing",
      "Misollar bilan tushuntiring",
      "Savollaringizni bo'laklarga ajrating",
      "Tilni aniq belgilang",
      "Qo'shimcha shartlar qo'shing",
      "To'g'ridan-to'g'ri savollar bering",
      "Takroriy so'rovlar yozing",
      "Ijobiy yoki salbiy natijalarni tushuntiring",
      "Natijalarni baholang va so'rovni takomillashtiring",
    ];

    List<IconData> icons = [
      FontAwesomeIcons.clipboardCheck,
      FontAwesomeIcons.book,
      FontAwesomeIcons.lightbulb,
      FontAwesomeIcons.tasks,
      FontAwesomeIcons.language,
      FontAwesomeIcons.cogs,
      FontAwesomeIcons.questionCircle,
      FontAwesomeIcons.syncAlt,
      FontAwesomeIcons.thumbsUp,
      FontAwesomeIcons.chartLine,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Yaxshi natija olish uchun maslahatlar",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        SizedBox(height: 10),
        ...List.generate(tips.length,
            (index) => _buildExpandableTip(index, tips[index], icons[index])),
      ],
    );
  }

  Widget _buildExpandableTip(int index, String title, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.teal[700],
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.orangeAccent),
        title: Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
        initiallyExpanded: expandedList[index],
        onExpansionChanged: (expanded) {
          setState(() {
            expandedList[index] = expanded;
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(_getTipDetails(index),
                style: TextStyle(fontSize: 16, color: Colors.white70)),
          ),
        ],
      ),
    ).animate().fade(duration: 600.ms);
  }

  String _getTipDetails(int index) {
    List<String> details = [
      "ChatGPTga aniq va lo'nda so'zlar bilan savol bering.",
      "Savolingizning kontekstini qo'shsangiz, aniqroq javob olasiz.",
      "Agar mumkin bo'lsa, misollar bilan tushuntiring.",
      "Savollaringizni kichik bo'laklarga ajrating.",
      "Agar javob ma'lum bir tilda bo'lishini xohlasangiz, ko'rsatib qo'ying.",
      "Natijaga bog'liq bo'lgan shartlar kiriting.",
      "Aniq va to'g'ridan-to'g'ri savollar bering.",
      "Agar birinchi natija yetarlicha aniq bo'lmasa, qayta so'rov bering.",
      "Istalgan natijani ta'riflab bering.",
      "Javobni tahlil qilib, agar kerak bo'lsa so'rovni o'zgartiring.",
    ];
    return details[index];
  }
}
