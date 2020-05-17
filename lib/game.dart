class Game {

  List<Field> gameFields = List<Field>();
  int height = 0;

  int size() => height * height;

  Game(this.height) {
    for (int i = 0; i < height*height; i++) {
      gameFields.add(Field(FieldState.OFF));
    }
  }
}

class Field {
  FieldState _checked = FieldState.NULL;
  FieldState _target;

  Field(this._target);

  set checked(FieldState value) {
    _checked = value;
  }

  set target(FieldState value) {
    if (target == FieldState.OFF) target = FieldState.NULL;
    _target = target;
  }

  FieldState get target => _target;

  FieldState get checked => _checked;
}

enum FieldState { ON, OFF, NULL }
