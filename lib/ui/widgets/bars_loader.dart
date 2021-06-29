import 'package:flutter/material.dart';

class BarsLoader extends StatefulWidget {
  final int duration;

  BarsLoader({Key key, this.duration}) : super(key: key);
  @override
  _BarsLoaderState createState() => _BarsLoaderState();
}

class _BarsLoaderState extends State<BarsLoader>
    with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation<double> _animation;

  double _width = 3;
  double _height = 10;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation = CurvedAnimation(
        parent: _animController, curve: Curves.easeOutSine);

    _animation = Tween<double>(begin: 1, end: _height).animate(curvedAnimation)
      ..addListener(() {
        setState(() {

        });
      });
    _animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _animation.value,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2)
      ),
    );
  }
}

class MyBarLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BarsLoader(duration: 500),
        SizedBox(width: 3),
        BarsLoader(duration: 1000),
        SizedBox(width: 3),
        BarsLoader(duration: 1500),
      ],
    );
  }
}

