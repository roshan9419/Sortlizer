import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/views/home_viewmodel.dart';
import 'package:sorting_visualization/ui/widgets/neumorphic_rect_btn.dart';
import 'package:sorting_visualization/ui/widgets/neumorphic_round_btn.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
                colors: [darkBackgroundStart, darkBackgroundFinish])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Sorting\n',
                              style: theme.textTheme.headline5.copyWith(
                                  color: lightGrayColor, letterSpacing: 1),
                              children: [
                            TextSpan(
                              text: 'Visualizer',
                              style: theme.textTheme.headline4.copyWith(
                                  color: Colors.white, letterSpacing: 2),
                            )
                          ])),
                      ExpandableButtons(),
                    ],
                  ),
                  Spacer(),
                  GetProgrammingQuote(),
                  SizedBox(height: 30),
                  Center(
                    child: NeumorphicButton(
                      onTap: model.moveToVisualizerView,
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      btnSize: 70,
                      btnColor: theme.primaryColor,
                      isPressed: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tap to Start',
                    textAlign: TextAlign.center,
                    style:
                        theme.textTheme.subtitle2.copyWith(color: Colors.white),
                  ),
                  Spacer(),
                  Text(
                    "Visualize different Sorting Algorithms",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.subtitle2
                        .copyWith(color: darkGrayColor, letterSpacing: 0.5),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NeumorphicRectButton(
                    btnWidth: 300,
                    child: TyperAnimatedTextKit(
                      text: model.getAlgorithmsList(),
                      textAlign: TextAlign.center,
                      repeatForever: true,
                      isRepeatingAnimation: true,
                      textStyle: theme.textTheme.subtitle1
                          .copyWith(color: Colors.white, letterSpacing: 1),
                      speed: Duration(milliseconds: 50),
                    ),
                  ),
                  // SizedBox(height: 20),
                  // Text(model.getAppVersion(), style: theme.textTheme.overline.copyWith(color: lightGrayColor)),
                  // SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class ExpandableButtons extends StatefulWidget {
  @override
  _ExpandableButtonsState createState() => _ExpandableButtonsState();
}

class _ExpandableButtonsState extends State<ExpandableButtons>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _btnColor;
  Animation<double> _animationIcon;
  Animation<double> _translateBtn;
  double _fabHeight = 55.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _btnColor = ColorTween(begin: Colors.blue, end: Colors.deepOrange).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 1.0, curve: Curves.linear)));
    _translateBtn = Tween<double>(begin: _fabHeight, end: 0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: Curves.easeOut)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() {
    isOpened ? _animationController.reverse() : _animationController.forward();
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueGrey,
      height: 220,
      child: Stack(
        overflow: Overflow.visible,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateBtn.value * 1.0, 0.0),
            child: ActionButton(
              color: Colors.deepOrange,
              toolTipText: 'About',
              iconData: Icons.info_outline,
            ),
          ),
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateBtn.value * 2.0, 0.0),
            child: ActionButton(
              color: Colors.green,
              toolTipText: 'Share',
              iconData: Icons.share,
            ),
          ),
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateBtn.value * 3.0, 0.0),
            child: ActionButton(
              color: Colors.deepPurpleAccent,
              toolTipText: 'Star',
              iconData: Icons.star_border_rounded,
            ),
          ),
          Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.only(top: 8.0),
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  animate();
                },
                heroTag: 'Menu',
                backgroundColor: darkGrayColor,
                child: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationIcon,
                  color: Colors.white,
                ),
                tooltip: 'Menu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String toolTipText;
  final Color color;
  final IconData iconData;
  final Function onTap;
  final double btnSize;

  const ActionButton(
      {Key key,
      this.toolTipText,
      this.color,
      this.iconData,
      this.onTap,
      this.btnSize = 55})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnSize,
      height: btnSize,
      padding: const EdgeInsets.only(top: 8.0),
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            print('Clicked');
            if (onTap != null) onTap();
          },
          heroTag: toolTipText,
          backgroundColor: color,
          child: Icon(
            iconData,
            size: 25,
            color: Colors.white,
          ),
          tooltip: toolTipText,
        ),
      ),
    );
  }
}

class GetProgrammingQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
              text: "// life motto\n",
              style: theme.textTheme.headline6.copyWith(color: darkGrayColor),
              children: [
                _getTextSpan(context, 'if', theme.primaryColor),
                _getTextSpan(context, ' (', Colors.white),
                _getTextSpan(context, 'sad()', theme.primaryColor),
                _getTextSpan(context, ' == ', Colors.deepOrange),
                _getTextSpan(context, 'true', Colors.white),
                _getTextSpan(context, ') {\n', Colors.white),
                _getTextSpan(context, '\t\t\t\tsad', theme.primaryColor),
                _getTextSpan(context, '.stop();\n', Colors.white),
                _getTextSpan(context, '\t\t\t\tbeAwesome();\n', Colors.white),
                _getTextSpan(context, '}', Colors.white),
              ])),
    );
  }

  TextSpan _getTextSpan(BuildContext context, String text, Color color) {
    return TextSpan(
        text: text,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: color, fontSize: 25));
  }
}
