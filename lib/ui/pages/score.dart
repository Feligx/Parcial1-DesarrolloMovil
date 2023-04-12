import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial1/ui/utilities/utils.dart';
import '../controller/GameController.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find();

    List<dynamic> result = getScore(controller.originalNumber.value, controller.testNumber.value);

    return Scaffold(
        appBar: AppBar(
          title: Text('Selección de Jugadores'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                  'Los puntajes son los siguientes:'
              ),
              Text('Famas: ${result[0]}'),
              Text('Puntos: ${result[1]}')
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
