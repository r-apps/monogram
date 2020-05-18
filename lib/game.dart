import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';

class Game {
  List<Field> gameFields = List<Field>();
  int _height = 0;


  int get height {
    while(_height == 0) {
      sleep(Duration(milliseconds: 10));
    }
    return _height;
  }


  set height(int value) {
    _height = value;
  }

  int size() => height * height;

  Game.withPattern(String pattern) {
    _createGameByPatter(pattern);
  }

  Game.fromSampleData() {
    rootBundle.loadString("sample-data/game-data.list").then((value) {
      var split = value.split("\n");
      var pattern = split[Random().nextInt(split.length)];
      _createGameByPatter(pattern);
      return null;
    });
  }

  Game(this._height) {
    for (int i = 0; i < height * height; i++) {
      gameFields.add(Field((i == 0) ? FieldState.ON : FieldState.OFF, this));
    }
  }

  bool isFinished() {
    return gameFields.every((element) {
      var checked = (element.checked == FieldState.NULL)
          ? FieldState.OFF
          : element.checked;
      return checked == element.target;
    });
  }

  void _createGameByPatter(String pattern) {
    this.height = sqrt(pattern.length).round();
    pattern.runes.forEach((element) {
      var i = int.parse(String.fromCharCode(element));
      if (i < 1)
        gameFields.add(Field(FieldState.OFF, this));
      else
        gameFields.add(Field(FieldState.ON, this));
    });
  }
}

class Field {
  FieldState _checked = FieldState.NULL;
  FieldState _target;
  Game _game;

  Field(this._target, this._game);

  set target(FieldState value) {
    if (target == FieldState.OFF) target = FieldState.NULL;
    _target = target;
  }

  FieldState get target => _target;

  FieldState get checked => _checked;

  setWinningState() {
    switch (_target) {
      case FieldState.ON:
        _checked = FieldState.OFF;
        break;
      case FieldState.OFF:
      case FieldState.NULL:
        _checked = FieldState.NULL;
        break;
    }
  }

  switchState() {
    switch (_checked) {
      case FieldState.ON:
        _checked = FieldState.OFF;
        break;
      case FieldState.OFF:
        _checked = FieldState.NULL;
        break;
      case FieldState.NULL:
        _checked = FieldState.ON;
        break;
    }
  }
}

enum FieldState { ON, OFF, NULL }
