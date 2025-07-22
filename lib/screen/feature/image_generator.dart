import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ImageGenerationTipsModern extends StatelessWidget {
  const ImageGenerationTipsModern({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tips = [
      {
        "title": "Aniq va batafsil prompt yozing",
        "desc":
            "Nima tasvirlanishini xohlasangiz, tushunarli va lo‘nda ayting.",
        "icon": FontAwesomeIcons.penFancy
      },
      {
        "title": "Ob'ekt va fonni tavsiflang",
        "desc":
            "Rasmda nima markazda va qanday fon bo‘lishi kerakligini yozing.",
        "icon": FontAwesomeIcons.image
      },
      {
        "title": "Ranglar va uslubni belgilang",
        "desc":
            "Masalan, 'yorqin ranglar', 'retro uslub', 'realistik' deb yozing.",
        "icon": FontAwesomeIcons.palette
      },
      {
        "title": "O‘lcham va nisbatni ko‘rsating",
        "desc": "Masalan: 'kvadrat 1024x1024', 'portret' yoki 'landshaft'.",
        "icon": FontAwesomeIcons.expand
      },
      {
        "title": "Kamera burchagi va yoritish",
        "desc":
            "Masalan: 'yuqoridan qarash', 'yumshoq yorug‘lik', 'dramatic lighting'.",
        "icon": FontAwesomeIcons.camera
      },
      {
        "title": "San’at uslubini aniqlang",
        "desc":
            "Masalan: 'watercolor', 'cyberpunk', 'oil painting', 'pixel art'.",
        "icon": FontAwesomeIcons.paintBrush
      },
      {
        "title": "Bir nechta variantlar sinab ko‘ring",
        "desc": "Xar xil promptlar yozib natijalarni solishtiring.",
        "icon": FontAwesomeIcons.shuffle
      },
      {
        "title": "Keraksiz elementlarni chiqarib tashlang",
        "desc": "Masalan: 'without text', 'no watermark', 'no background'.",
        "icon": FontAwesomeIcons.ban
      },
      {
        "title": "Tuyg‘u yoki atmosfera kiriting",
        "desc": "Masalan: 'mystical', 'peaceful', 'romantic sunset'.",
        "icon": FontAwesomeIcons.cloudSun
      },
      {
        "title": "Qo‘shimcha detallarni kiriting",
        "desc": "Masalan: 'gold frame', 'foggy background', 'high detail'.",
        "icon": FontAwesomeIcons.star
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("AI Rasm Tavsiyalari"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final item = tips[index];
          return Animate(
            effects: [
              FadeEffect(duration: 400.ms),
              SlideEffect(duration: 300.ms)
            ],
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade100,
                  child: Icon(item['icon'], color: Colors.deepPurple),
                ),
                title: Text(item['title'],
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(item['desc'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
