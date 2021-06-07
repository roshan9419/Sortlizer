import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/views/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

Color blueThemeColor1 = Color(0xff2E4EEE);

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: theme.primaryColor,
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 150,
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 30, right: 30),
                ),
                Container(
                  width: 30,
                  height: 100,
                  color: Colors.white,
                )
              ],
            ),
            Text(
              "Sorting\nVisualizer",
              style: theme.textTheme.headline4
                  .copyWith(color: Colors.white, fontSize: 48.0),
            ),
            Center(
              child: Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.symmetric(vertical: 50.0),
                child: FloatingActionButton(
                  onPressed: () {
                    model.moveToVisualizerView();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: theme.primaryColor,
                    size: 50.0,
                  ),
                ),
              ),
            ),
            Text(
              "Which algorithm you want to visualize?",
              style: theme.textTheme.subtitle1.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.5),
            ),
            SizedBox(
              height: 20,
            ),
            OutlineButton(
              onPressed: () => print("Button CLICKED"),
              child: Text(
                'Bubble Sort',
                style: theme.textTheme.subtitle1.copyWith(
                    color: Colors.white, letterSpacing: 1, fontSize: 20.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              borderSide: BorderSide(color: Colors.white, width: 1),
            )
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
