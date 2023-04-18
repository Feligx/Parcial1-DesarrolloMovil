import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final List buttons;
  const ButtonRow({Key? key, required this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(buttons.length, (index) {
        return ElevatedButton(
            onPressed: buttons[index]['onPressed'],
            child: Text(buttons[index]['text'])
        );
      })
    );
  }
}
