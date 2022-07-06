import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AshokChakra extends StatefulWidget {
  @override
  _AshokChakraState createState() => _AshokChakraState();
}

class _AshokChakraState extends State<AshokChakra>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double size = 0.0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(minutes: 5), vsync: this);
    super.initState();
    _controller.repeat();
    size = 100.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(size / 2)),
      child: AnimatedBuilder(
        animation: _controller,
        child: SvgPicture.asset(
          'assets/images/ashok_chakra.svg',
          height: size,
          width: size,
        ),
        builder: (BuildContext context, Widget? _widget) {
          return Transform.rotate(
            angle: _controller.value * 300,
            child: _widget,
          );
        },
      ),
    );
  }
}
