import 'package:flutter/material.dart';
import 'package:parcial1/ui/pages/solo.dart';
import 'package:get/get.dart';

import '../controller/GameController.dart';

class PlayerSelectionView extends StatelessWidget {
  const PlayerSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: Text('Selección de Jugadores'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                  'Bienvenido al juego, por favor elige una de las siguientes dificultades:'
              ),
              ElevatedButton(onPressed: (){
                setPlayers(controller, 0);
              }, child: Text('Solitario')),
              ElevatedButton(onPressed: (){
                setPlayers(controller, 1);
              }, child: Text('Versus'))
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