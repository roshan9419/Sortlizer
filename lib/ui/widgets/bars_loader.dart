import 'dart:math';

import 'package:flutter/material.dart';

class BarsLoader extends StatefulWidget {
  @override
  _BarsLoaderState createState() => _BarsLoaderState();
}

class _BarsLoaderState extends State<BarsLoader>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _sizeAnimation1;
  Animation _sizeAnimation2;
  Animation _sizeAnimation3;

  double _width = 3;
  double _height = 10;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _sizeAnimation1 = Tween<double>(begin: 1, end: _height - 3).animate(_controller);
    _sizeAnimation2 = Tween<double>(begin: 5, end: _height).animate(_controller);
    _sizeAnimation3 = Tween<double>(begin: 1, end: _height - 3).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _width,
            height: _sizeAnimation1.value,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Container(
            width: _width,
            height: _sizeAnimation2.value,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Container(
            width: _width,
            height: _sizeAnimation3.value,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
