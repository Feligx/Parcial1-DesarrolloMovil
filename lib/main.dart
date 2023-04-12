import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial1/ui/controller/GameController.dart';
import 'package:parcial1/ui/pages/difficulty.dart';

void main() {
  Get.lazyPut<GameController>(() => GameController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Puntos y Famas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PickDifficultyView(),
    );
  }
}
