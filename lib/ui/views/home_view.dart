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
            child: Column(
              children: [
                SizedBox(height: 10),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Sorting\n',
                        style: theme.textTheme.headline5
                            .copyWith(color: lightGrayColor, letterSpacing: 1),
                        children: [
                          TextSpan(
                            text: 'Visualizer',
                            style: theme.textTheme.headline4.copyWith(
                                color: Colors.white, letterSpacing: 2),
                          )
                        ])),
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
                  style:
                      theme.textTheme.subtitle2.copyWith(color: Colors.white),
                ),
                Spacer(),
                Text(
                  "Visualize different Sorting Algorithms",
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

class GetProgrammingQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return RichText(
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
            ]));
  }

  TextSpan _getTextSpan(BuildContext context, String text, Color color) {
    return TextSpan(
        text: text,
        style: Theme.of(context).textTheme.headline6.copyWith(color: color, fontSize: 25));
  }
}
