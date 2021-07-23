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
                  Container(
                    // color: Colors.blueGrey,
                    height: 250,
                    child: Stack(
                      fit: StackFit.passthrough,
                      clipBehavior: Clip.none,
                      overflow: Overflow.visible,
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
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Column(
                            children: [
                              NeumorphicButton(
                                icon: Icon(
                                  model.isMenuOpened ? Icons.close : Icons.menu,
                                  color: Colors.white,
                                ),
                                btnSize: 50,
                                onTap: model.onMenuBtnClick,
                              ),
                              if (model.isMenuOpened)
                                ActionButton(
                                    toolTipText: 'About',
                                    color: theme.primaryColor,
                                    iconData: Icons.info_outline,
                                    onTap: model.showAboutApp),
                              if (model.isMenuOpened)
                                ActionButton(
                                    toolTipText: 'Share',
                                    color: Color(0xff0CAA7F),
                                    iconData: Icons.share),
                              if (model.isMenuOpened)
                                ActionButton(
                                    toolTipText: 'Rate',
                                    color: orangeThemeColor,
                                    iconData: Icons.star),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 150,
                            left: 0,
                            right: 0,
                            child: GetProgrammingQuote()),
                      ],
                    ),
                  ),
                  Spacer(),
                  // SizedBox(height: 100),
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
