import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../apis/apis.dart';
import '../helper/global.dart';
import '../helper/my_dialog.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();

  final status = Status.none.obs;

  final url = ''.obs;

  final imageList = <String>[].obs;

  Future<void> createAIImage() async {
    if (textC.text.trim().isNotEmpty) {
      OpenAI.apiKey = apiKey;
      status.value = Status.loading;

      OpenAIImageModel image = await OpenAI.instance.image.create(
        prompt: textC.text,
        n: 1,
        size: OpenAIImageSize.size512,
        responseFormat: OpenAIImageResponseFormat.url,
      );
      url.value = image.data[0].url.toString();

      status.value = Status.complete;
    } else {
      MyDialog.info('Yaratmoqchi bo\'lgan rasmni tasvirlang !');
    }
  }

  void downloadImage() async {
    try {
      //To show loading
      MyDialog.showLoadingDialog();

      log('url: $url');

      final bytes = (await get(Uri.parse(url.value))).bodyBytes;
      final dir = await getTemporaryDirectory();

      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      log('filePath: ${file.path}');
      //save image to gallery
      Uint8List imageData = await file.readAsBytes();

      final result = await ImageGallerySaverPlus.saveImage(
        imageData,
        name: "$appName-${DateTime.now().millisecondsSinceEpoch}",
        quality: 100,
      );

      if (result['isSuccess']) {

        Get.back();

        MyDialog.success('Rasm Galereyaga yuklab olindi!');
      } else {
        throw Exception('Failed to save image');
      }
    } catch (e) {
      //hide loading
      Get.back();
      MyDialog.error('Nimadir xato ketdi (Birozdan keyin qayta urinib ko‘ring)!');
      log('downloadImageE: $e');
    }
  }

  void shareImage() async {
    try {
      //To show loading
      MyDialog.showLoadingDialog();

      log('url: $url');

      final bytes = (await get(Uri.parse(url.value))).bodyBytes;
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/ai_image.png').writeAsBytes(bytes);

      log('filePath: ${file.path}');

      //hide loading
      Get.back();

      await Share.shareXFiles([XFile(file.path)],
          text:
          'Sarvarbek tomonidan Ai Assistant ilovasi tomonidan yaratilgan ushbu ajoyib tasvirni tekshiring');
    } catch (e) {
      //hide loading
      Get.back();
      MyDialog.error('Nimadir xato ketdi (Birozdan keyin qayta urinib ko‘ring)!');
      log('downloadImageE: $e');
    }
  }

  Future<void> searchAiImage() async {
    if (textC.text.trim().isNotEmpty) {
      status.value = Status.loading;

      imageList.value = await APIs.searchAiImages(textC.text);

      if (imageList.isEmpty) {
        MyDialog.error('Nimadir xato ketdi (Birozdan keyin qayta urinib ko‘ring)!');

        return;
      }

      url.value = imageList.first;

      status.value = Status.complete;
    } else {
      MyDialog.info('Yaratmoqchi bo\'lgan rasmni tasvirlang !');
    }
  }
}