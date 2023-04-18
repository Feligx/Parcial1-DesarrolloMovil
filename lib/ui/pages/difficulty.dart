import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial1/ui/pages/players.dart';
import 'package:parcial1/ui/widgets/button_row.dart';

import '../controller/GameController.dart';

class PickDifficultyView extends StatelessWidget {
  PickDifficultyView({Key? key }) : super(key: key);

  final GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Stack(
          children: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Text('Puntos y Famas',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'Bienvenido al juego, por favor elige una de las siguientes dificultades:',
                    textAlign: TextAlign.center,
                  ),
                ),
                ButtonRow(
                  buttons: [
                    {
                      "onPressed": () {
                        setDifficulty(controller, 3);
                      },
                      "text": 'Fácil'
                    },
                    {
                        "onPressed": (){
                          setDifficulty(controller, 4);
                        },
                        "text": 'Normal'
                    },
                    {
                      "onPressed": (){
                        setDifficulty(controller, 5);
                      },
                      "text": 'Difícil'
                    },
                    {
                      "onPressed": (){
                        setDifficulty(controller, 6);
                      },
                      "text": 'Letal'
                    }
                  ],
                ),
              ],
            ),
          ],
        ),
            const Positioned(
                left: 0,
                right: 0,
                bottom: 16,
                child: Center(child: Text('Hecho por Felipe Martínez Mirque'))
            )
        ])
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


void setDifficulty(controller, int difficulty) {
  controller.setDifficulty(difficulty);
  Get.to(() => const PlayerSelectionView());
}