import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game.dart';
import 'notifications.dart';

class GameWidget extends StatefulWidget {
  Game game;
  Random random = Random();
  List _fields;

  GameWidget() {
    //this.game = Game.withPattern("1101110101010100101000100");
    this.game = Game.fromSampleData();
    this.fields = game.gameFields;
  }

  set fields(List<Field> value) {
    _fields = value;
  }

  get fields =>
      {_fields.map<Widget>((e) => FieldWidget(e)).toList(growable: false)};

  @override
  State<StatefulWidget> createState() {
    return _GameState();
  }
}

class _GameState extends State<GameWidget> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<FieldChangedNotification>(
        onNotification: (e) {
          setState(() {
            if (widget.game.isFinished()) {
              widget.game.gameFields.forEach((element) {
                element.setWinningState();
              });
            }
          });
          return true;
        },
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.game.height),
          shrinkWrap: true,
          children: widget.fields.first,
        )
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
  changeChecked() {
    widget.field.switchState();
    FieldChangedNotification(widget.field).dispatch(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            this.setState(() {
              changeChecked();
            }),
        child: Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            //    color: StatusColorMap[state],
              border: const Border(
                top: BorderSide(color: Colors.black, width: 1.0),
                left: BorderSide(color: Colors.black, width: 1.0),
                bottom: BorderSide(color: Colors.black, width: 1.0),
                right: BorderSide(color: Colors.black, width: 1.0),
              ),
              color: _getColor()),
          child: Text(""),
        ));
  }

  _getColor() {
    var color = Colors.white;
    switch (widget.field.checked) {
      case FieldState.ON:
        color = Colors.green;
        break;
      case FieldState.OFF:
        color = Colors.red;
        break;
      case FieldState.NULL:
      // TODO: Handle this case.
        break;
    }
    return color;
  }
}
