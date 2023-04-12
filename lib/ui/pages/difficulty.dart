import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial1/ui/pages/players.dart';

import '../controller/GameController.dart';

class PickDifficultyView extends StatelessWidget {
  PickDifficultyView({Key? key }) : super(key: key);

  final GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puntos y Famas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                'Bienvenido al juego, por favor elige una de las siguientes dificultades:'
            ),
            ElevatedButton(onPressed: (){
              setDifficulty(controller, 3);
            }, child: Text('Fácil')),
            ElevatedButton(onPressed: (){
              setDifficulty(controller, 4);
            }, child: Text('Normal')),
            ElevatedButton(onPressed: (){
              setDifficulty(controller, 5);
            }, child: Text('Difícil')),
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


void setDifficulty(controller, int difficulty) {
  controller.setDifficulty(difficulty);
  Get.to(() => const PlayerSelectionView());
}