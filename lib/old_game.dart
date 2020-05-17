import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:monogramm/clickableElement.dart';

class Game extends StatefulWidget {
  Game(this.gameSetting) {
    print("Game with fieldSize of ${gameSetting.value.fieldSize}");
  }

  ValueListenable<GameSetting> gameSetting;

  @override
  State<StatefulWidget> createState() {
    return _GameState(gameSetting);
  }
}

class _GameState extends State<Game> {
  _GameState(this.gameSetting);

  ValueListenable<GameSetting> gameSetting;

  List<Widget> clickableItems() {
    final columns = gameSetting.value.fieldSize;
    print("Getting $columns clickable items");
    var list = new List<Widget>();
    for (int i = 0; i <= columns; i++) {
      list.add(ClickableElement.withContent("Header $i"));
    }
    for (int i = 0; i < columns * columns; i++) {
      if (i % columns == 0)
        list.add(ClickableElement.withContent("Column Header"));
      list.add(ClickableElement());
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final columns = gameSetting.value.fieldSize;
    print("Columns: $columns");
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns + 1),
      shrinkWrap: true,
      children: clickableItems(),
    );
  }
}

class GameSetting {
  int fieldSize;

  GameSetting(this.fieldSize);
}
