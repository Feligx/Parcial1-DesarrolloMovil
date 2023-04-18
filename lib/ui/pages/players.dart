import 'package:flutter/material.dart';
import 'package:parcial1/ui/pages/solo.dart';
import 'package:get/get.dart';
import 'package:parcial1/ui/widgets/button_row.dart';

import '../controller/GameController.dart';

class PlayerSelectionView extends StatelessWidget {
  const PlayerSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find();

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Selección de Jugadores',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
                    '¿Jugarás contra el sistema o contra otro jugador?',
                    textAlign: TextAlign.center
                ),
              ),
              ButtonRow(
                buttons: [
                  {
                    "onPressed": () {
                      setPlayers(controller, 0);
                    },
                    "text": 'Solitario'
                  },
                  {
                    "onPressed": (){
                      setPlayers(controller, 1);
                    },
                    "text": 'Versus'
                  }
                ],
              )
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

void setPlayers(controller, int mode) {
  controller.setPlayerMode(mode);

  Get.to(() => const SoloModeView());
}