import 'package:flutter/material.dart';

class ImageGenerator extends StatefulWidget {
  const ImageGenerator({super.key});

  @override
  State<ImageGenerator> createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rasm bilan ishlash'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 16.0,
          children: [
            SizedBox(
              height: 18,
            ),
            Text(
              'Rasm bilan ishlash uchun maslaharlar',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),

          ],
        ),
      ),
    );
  }
}
