import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/views/home_viewmodel.dart';
import 'package:sorting_visualization/ui/widgets/neumorphic_round_btn.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var style =
        SystemUiOverlayStyle(systemNavigationBarColor: darkBackgroundFinish);
    SystemChrome.setSystemUIOverlayStyle(style);

    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: theme.primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 40, left: 20, bottom: 0),
                  child: Text(
                    "Sorting\nVisualizer",
                    style: theme.textTheme.headline4.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(
                          color: Color(0xdadbdada),
                          offset: Offset(2, 2),
                          blurRadius: 10
                        )],
                        fontSize: 48.0),
                  )),
              Transform.translate(
                offset: Offset(0, -10),
                child: SvgPicture.asset(
                  'assets/images/buildings.svg',
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: NeumorphicButton(
                  onTap: model.moveToVisualizerView,
                  icon: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40,),
                  btnSize: 60,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Visualize different Sorting Algorithms",
                style: theme.textTheme.subtitle1.copyWith(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: OutlineButton(
                  onPressed: () => print("Button CLICKED"),
                  child: TyperAnimatedTextKit(
                    text: model.getAlgorithmsList(),
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    textStyle: theme.textTheme.subtitle1
                        .copyWith(color: Colors.white, letterSpacing: 1),
                    speed: Duration(milliseconds: 50),
                  ),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
