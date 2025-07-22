import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),

                SizedBox(height: 20),

                // "Kim yaratdi?" bo‘limi
                _buildSectionTitle("👨‍💻 Kim Yaratdi?"),
                _buildAnimatedCard(
                  "OpenAI tomonidan ishlab chiqilgan",
                  "ChatGPT OpenAI kompaniyasi tomonidan 2015-yilda Sam Altman, Elon Musk va boshqalar tomonidan tashkil etilgan.",
                  Icons.group,
                ),
                _buildAnimatedCard(
                  "Maqsad 🎯",
                  "OpenAI sun'iy intellektni inson manfaatlari yo‘lida rivojlantirishni maqsad qilgan.",
                  Icons.lightbulb_outline,
                ),

                SizedBox(height: 20),

                // Tarix bo‘limi
                _buildSectionTitle("📅 ChatGPT Tarixi"),
                _buildHistoryItem("2015", "OpenAI tashkil etildi."),
                _buildHistoryItem("2018", "GPT-1 chiqarildi."),
                _buildHistoryItem("2019", "GPT-2 ommaga taqdim qilindi."),
                _buildHistoryItem("2020", "GPT-3 chiqarildi (175B parametr)."),
                _buildHistoryItem("2022", "ChatGPT (GPT-3.5) ommaga ochildi."),
                _buildHistoryItem("2023", "GPT-4 ishlab chiqildi."),

                SizedBox(height: 20),

                // Qiziqarli faktlar
                _buildSectionTitle("🤯 Qiziqarli Faktlar"),
                _buildAnimatedCard(
                  "GPT-4 ning narxi 💰",
                  "Uni o‘qitish uchun taxminan **100 million dollar** sarflangan!",
                  Icons.monetization_on,
                ),
                _buildAnimatedCard(
                  "Parametrlar soni 🔢",
                  "GPT-3 da **175 milliard**, GPT-4 esa **trillionlab** parametrga ega!",
                  Icons.memory,
                ),
                _buildAnimatedCard(
                  "Ma'lumot hajmi 📚",
                  "GPT-4 **570GB** hajmli matnlar bilan o‘qitilgan.",
                  Icons.storage,
                ),
                _buildAnimatedCard(
                  "Energiyaga talab ⚡",
                  "GPT-4 ishga tushirilganda butun shahar elektr sarfi kabi energiya talab qiladi!",
                  Icons.bolt,
                ),
                _buildAnimatedCard(
                  "Javob uzunligi 📝",
                  "ChatGPT **1000+ jumla** uzunlikdagi javob bera oladi.",
                  Icons.text_fields,
                ),
                _buildAnimatedCard(
                  "Ko'p tilli qo‘llab-quvvatlash 🌍",
                  "ChatGPT **95+ tilni** tushunadi va ularda javob bera oladi.",
                  Icons.language,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header bo‘limi
  Widget _buildHeader() {
    return Center(
      child: FadeInDown(
        duration: Duration(milliseconds: 800),
        child: Column(
          children: [
            Icon(Icons.chat, size: 80, color: Colors.white),
            SizedBox(height: 10),
            Text(
              "ChatGPT Haqida",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Sun'iy intellektning inqilobiy modeli",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return FadeInLeft(
      duration: Duration(milliseconds: 1000),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(String title, String description, IconData icon) {
    return FadeInUp(
      duration: Duration(milliseconds: 900),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String year, String description) {
    return FadeInRight(
      duration: Duration(milliseconds: 1000),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child:
                Text(year, style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          title: Text(
            description,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
