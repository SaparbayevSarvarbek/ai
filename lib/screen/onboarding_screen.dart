import 'package:ai/screen/login_screen.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../helper/global.dart';
import '../model/onboard.dart';
import '../widget/custom_btn.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [
      //onboarding 1
      Onboard(
          title: 'Mendan biror narsa so\'rang',
          subtitle:
              'Men sizning eng yaxshi do\'stingiz bo\'lishim mumkin va siz mendan hamma narsani so\'rashingiz mumkin va men sizga yordam beraman!',
          lottie: 'ai_ask_me'),

      //onboarding 2
      Onboard(
        title: 'Tasavvurdan haqiqatga',
        lottie: 'ai_play',
        subtitle:
            'Biror narsani tasavvur qilgan narsani menga izohlang, men uni siz uchun yaratib beraman!',
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: c,
        itemCount: list.length,
        itemBuilder: (ctx, ind) {
          final isLast = ind == list.length - 1;

          return Column(
            children: [
              //lottie
              Lottie.asset('assets/lottie/${list[ind].lottie}.json',
                  height: mq.height * .6, width: isLast ? mq.width * .7 : null),

              //title
              Text(
                list[ind].title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .5),
              ),

              //for adding some space
              SizedBox(height: mq.height * .015),

              //subtitle
              SizedBox(
                width: mq.width * .7,
                child: Text(
                  list[ind].subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13.5,
                      letterSpacing: .5,
                      color: Theme.of(context).lightTextColor),
                ),
              ),

              const Spacer(),

              //dots

              Wrap(
                spacing: 10,
                children: List.generate(
                    list.length,
                    (i) => Container(
                          width: i == ind ? 15 : 10,
                          height: 8,
                          decoration: BoxDecoration(
                              color: i == ind ? Colors.blue : Colors.grey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                        )),
              ),

              const Spacer(),

              //button
              CustomBtn(
                  onTap: () {
                    if (isLast) {
                      Get.off(() => const LoginPage());
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (_) => const HomeScreen()));
                    } else {
                      c.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.ease);
                    }
                  },
                  text: isLast ? 'Login' : 'Keyingi'),

              const Spacer(flex: 2),
            ],
          );
        },
      ),
    );
  }
}
