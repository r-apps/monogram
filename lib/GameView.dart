import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class GameWidget extends StatefulWidget {
  Game game;
  Random random = Random();
  List _fields;


  GameWidget() {
    this.game = Game(random.nextInt(15));
    this.fields = game.gameFields;
  }


  set fields(List<Field> value) {
    _fields = value;
  }

  get fields => {
    _fields.map<Widget>((e) => FieldWidget(e)).toList(growable: false)
  };

  @override
  State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<GameWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.game.height),
      shrinkWrap: true,
      children: widget.fields.first,
    );
  }
}

class FieldWidget extends StatefulWidget {
  Field field;

  FieldWidget(this.field);

  @override
  State<StatefulWidget> createState() {
    return _FieldState();
  }

}

class _FieldState extends State<FieldWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //onTap: () => changeColor(),
        child: Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
          //    color: StatusColorMap[state],
              border: const Border(
                top: BorderSide(color: Colors.black, width: 1.0),
                left: BorderSide(color: Colors.black, width: 1.0),
                bottom: BorderSide(color: Colors.black, width: 1.0),
                right: BorderSide(color: Colors.black, width: 1.0),
              )),
          child: Text(
              "Content"
          ),
        ));
  }
}