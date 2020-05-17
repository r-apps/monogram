import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

const grey = Color(0xFFF5F5F5);
const orange = Colors.orange;

class ClickableElement extends StatefulWidget {
  var content = "";


  @override
  State<StatefulWidget> createState() => _ClickableElementState(content);

  ClickableElement();
  ClickableElement.withContent(this.content);
}

class _ClickableElementState extends State<ClickableElement> {
  var state = Status.off;

  var content = "test";

  _ClickableElementState(this.content);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => changeColor(),
        child: Container(
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: StatusColorMap[state],
              border: const Border(
                top: BorderSide(color: Colors.black, width: 1.0),
                left: BorderSide(color: Colors.black, width: 1.0),
                bottom: BorderSide(color: Colors.black, width: 1.0),
                right: BorderSide(color: Colors.black, width: 1.0),
              )),
          child: Text(
            content
          ),
        ));
  }

  changeColor() async {
    var vibrator = await Vibration.hasVibrator();
    var amplitude = await Vibration.hasAmplitudeControl();
    if (vibrator) {
      Vibration.vibrate(duration: 10, intensities: [1]);
    }
    setState(() {
      switch (this.state) {
        case Status.on:
          this.state = Status.off;
          break;
        case Status.off:
          this.state = Status.on;
          break;
      }
    });
  }
}

enum Status { on, off }

const StatusColorMap = {Status.on: orange, Status.off: grey};
