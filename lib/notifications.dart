import 'package:flutter/cupertino.dart';

import 'game.dart';

class FieldChangedNotification extends Notification {
  Field field;

  FieldChangedNotification(this.field);
}