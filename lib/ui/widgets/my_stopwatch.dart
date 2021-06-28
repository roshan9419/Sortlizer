import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';

class MyStopWatch extends StatefulWidget {
  final bool onGoing;

  const MyStopWatch({Key key, this.onGoing}) : super(key: key);

  @override
  _MyStopWatchState createState() => _MyStopWatchState();
}

class _MyStopWatchState extends State<MyStopWatch> {
  Stopwatch _stopwatch = new Stopwatch();
  bool isStarted = true;


  init() {
    if(isStarted)
    setState(() {
      if (widget.onGoing) _stopwatch.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_stopwatch.elapsed.inMicroseconds}ms",
      style: Theme.of(context).textTheme.caption
          .copyWith(color: lightGrayColor, letterSpacing: 0.5),
    );
  }
}