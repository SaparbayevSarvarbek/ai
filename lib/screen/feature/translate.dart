import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TranslationInfoPage extends StatelessWidget {
  const TranslationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: AppBar(
        title: const Text("Tarjima haqida"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Lottie.asset('assets/lottie/ai_play.json', height: 180)),
            const SizedBox(height: 10),
            const Text(
              "ChatGPT yordamida tarjima qilish",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            const SizedBox(height: 12),
            const Text(
              "Siz ChatGPT'dan istalgan tilda matn tarjimasi uchun foydalanishingiz mumkin. "
              "Quyidagi ko‘rinishda yozing:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("📝 Misollar:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                        "• 'Please translate this to Uzbek: Hello, how are you?'"),
                    Text("• 'Translate this to Russian: I love programming.'"),
                    Text(
                        "• 'Ingliz tilidan o‘zbek tiliga tarjima qil: I have a dream.'"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "✅ Tavsiyalar:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _tipCard(
                "Til nomini aniq yozing (masalan: 'to French', 'to Uzbek')."),
            _tipCard("Oddiy va tushunarli matnlar yozishga harakat qiling."),
            _tipCard(
                "Tarjima natijasini ikki tilda solishtirib o‘qib chiqing."),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Bu tugma ChatGPT bilan tarjima sahifasiga olib borishi mumkin.
                },
                icon: const Icon(Icons.translate),
                label: const Text("Tarjima qilish sahifasiga o‘tish"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tipCard(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
