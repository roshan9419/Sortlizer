import 'package:flutter/material.dart';

class BarsLoader extends StatefulWidget {
  final int duration;
  final Color? color;
  final double? barWidth;
  final double? barHeight;

  BarsLoader(
      {Key? key,
      required this.duration,
      this.color,
      this.barWidth,
      this.barHeight})
      : super(key: key);

  @override
  _BarsLoaderState createState() => _BarsLoaderState();
}

class _BarsLoaderState extends State<BarsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;

  double _width = 3;
  double _height = 10;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.easeOutSine);

    _animation = Tween<double>(begin: 1, end: widget.barHeight ?? _height)
        .animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
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
      width: widget.barWidth ?? _width,
      height: _animation.value,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(2)),
    );
  }
}

class MyBarLoader extends StatelessWidget {
  final Color barColor;
  final double? barWidth;
  final double? barHeight;

  const MyBarLoader(
      {Key? key, this.barColor = Colors.white, this.barWidth, this.barHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BarsLoader(
            duration: 500,
            color: barColor,
            barWidth: barWidth,
            barHeight: barHeight),
        SizedBox(width: 3),
        BarsLoader(
            duration: 1000,
            color: barColor,
            barWidth: barWidth,
            barHeight: barHeight),
        SizedBox(width: 3),
        BarsLoader(
            duration: 1500,
            color: barColor,
            barWidth: barWidth,
            barHeight: barHeight),
      ],
    );
  }
}
