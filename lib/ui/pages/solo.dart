import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial1/ui/pages/difficulty.dart';
import 'package:parcial1/ui/pages/score.dart';
import '../controller/GameController.dart';
import '../utilities/utils.dart';

class SoloModeView extends StatefulWidget {
  const SoloModeView({Key? key}) : super(key: key);

  @override
  State<SoloModeView> createState() => _SoloModeViewState();
}

class _SoloModeViewState extends State<SoloModeView> {
  late List<TextEditingController> _textControllers;

  static final GameController controller = Get.find();
  var famas = 0;
  var puntos = 0;
  var famasIndex = [];
  final _formFieldKey = GlobalKey<FormState>();
  bool _hasRepeatedDigits = false;

  @override
  void initState() {
    super.initState();
    _textControllers = List.generate(controller.difficulty.value == 6 ? 5 : controller.difficulty.value, (index) => TextEditingController());
    if (controller.mode.value == 0) {
      String systemNumber;
      if (controller.difficulty.value == 6) {
        systemNumber = randHexNumber(5);
      } else {
        systemNumber = randNumber(controller.difficulty.value);
      }
      controller.setOriginalNumber(systemNumber);
    }
  }

  @override
  void dispose() {
    _textControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              controller.resetGame();
              Get.back();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                controller.getGameScreenTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
                ),
              ),
              Text('Famas: ${famas} Puntos: ${puntos}', textAlign: TextAlign.center,),
              Form(
                key: _formFieldKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  List.generate(controller.difficulty.value == 6 ? 5 : controller.difficulty.value, (index) => Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width / (controller.difficulty.value == 6 ? 5 : controller.difficulty.value),
                    child: TextFormField(
                      keyboardType: controller.difficulty.value != 6 ? const TextInputType.numberWithOptions() : TextInputType.text,
                      controller: famasIndex.contains(index) ? null : _textControllers[index],
                      maxLength: 1,
                      buildCounter: null,
                      textInputAction: TextInputAction.next,
                      initialValue: famasIndex.contains(index) ? controller.originalNumber.value[index] : null,
                      readOnly: famasIndex.contains(index),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: !famasIndex.contains(index) ? OutlineInputBorder() : InputBorder.none,
                          counter: Container(height: 0),
                      ),
                      validator: (value) {

                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }

                        if (hasRepeatedDigits(_textControllers.map((e) => e.text).join())) {
                          setState(() {
                            _hasRepeatedDigits = true;
                          });
                          return ' ';
                        } else {
                          setState(() {
                            _hasRepeatedDigits = false;
                          });
                        }
                        return null;
                      },
                    ),
                  ))
                ,
                )
              ),
              Text(_hasRepeatedDigits ? 'No se permiten números repetidos' : ' ', style: const TextStyle(color: Colors.red),),
              ElevatedButton(
                  onPressed: (){
                    if (_formFieldKey.currentState!.validate()) {
                      var valueToCompare = _textControllers.map((e) => e.text).join();
                      controller.increaseScore();

                      if (controller.mode.value == 1) {
                        if (controller.originalNumber.isEmpty) {
                          controller.setOriginalNumber(valueToCompare);
                          controller.changePlayer();
                          controller.resetScore();
                          _formFieldKey.currentState?.reset();
                          return;
                        } else {
                          controller.setTestNumber(valueToCompare);
                          controller.setPlayerScore();
                          List<dynamic> result = getScore(controller.originalNumber.value, controller.testNumber.value);

                          if (result[0].length == (controller.difficulty.value == 6 ? 5 : controller.difficulty.value)) {
                            controller.resetNumbers();
                            controller.resetScore();
                            controller.checkWinner();

                            setState(() {
                              famasIndex = [];
                              famas = 0;
                              puntos = 0;
                            });

                            _formFieldKey.currentState?.reset();
                            for (var element in _textControllers) {
                              element.clear();
                            }
                            return;
                          }

                          setState(() {
                            famasIndex = result[0];
                            famas = result[0].length;
                            puntos = result[1];
                          });
                          return;
                        }
                      }

                      controller.setTestNumber(valueToCompare);

                      List<dynamic> result = getScore(controller.originalNumber.value, controller.testNumber.value);
                      if (result[0].length == (controller.difficulty.value == 6 ? 5 : controller.difficulty.value)) {
                        Get.defaultDialog(
                            title: 'Ganaste',
                            middleText: 'Felicidades, has ganado el juego',
                            textConfirm: 'Aceptar',
                            onConfirm: () {
                              controller.resetGame();
                              Get.offAll(() => PickDifficultyView());
                            }
                        );
                      }
                      setState(() {
                        famasIndex = result[0];
                        famas = result[0].length;
                        puntos = result[1];
                      });
                    }
                  },
                  child: const Text('Comprobar')
              )
            ],
          ),
        ),
      floatingActionButton: famasIndex.length < (controller.difficulty.value == 6 ? 5 : controller.difficulty.value) ? FloatingActionButton(
        onPressed: () {
          setState(() {
            if (famasIndex.length == (controller.difficulty.value == 6 ? 5 : controller.difficulty.value)) {
              return;
            }

            famasIndex.isEmpty ? famasIndex.add(0) : famasIndex.add(famasIndex.last + 1);
            _textControllers[famasIndex.last].text = controller.originalNumber.value[famasIndex.last];
            if (famasIndex.length == (controller.difficulty.value == 6 ? 5 : controller.difficulty.value)) {
              controller.hintIncreaseScore(valueToAdd: 4);
              return;
            }
            controller.hintIncreaseScore();
          });
        },
        child: const Icon(Icons.lightbulb_outline),
      ) : null,
    );
  }
}
