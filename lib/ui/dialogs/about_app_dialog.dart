import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sorting_visualization/utils/app_info.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ui_theme.dart';
import '../../utils/app_info.dart';

class AboutAppDialog extends StatelessWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  const AboutAppDialog({Key key, this.dialogRequest, this.onDialogTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          // borderRadius: new BorderRadius.all(new Radius.circular(0.0)),
          gradient: darkGradient,
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(dialogRequest.title,
                    style: theme.textTheme.subtitle1
                        .copyWith(color: Colors.white)),
                Spacer(),
                Container(
                  width: 25,
                  height: 25,
                  child: FloatingActionButton(
                    onPressed: () =>
                        onDialogTap(DialogResponse(confirmed: true)),
                    mini: true,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    backgroundColor: theme.primaryColor,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            RichText(
                text: TextSpan(
                    text: "Hi, I'm ",
                    style: theme.textTheme.subtitle2
                        .copyWith(color: Colors.white70),
                    children: [
                  TextSpan(
                    text: "$developerName 👋",
                    style: theme.textTheme.subtitle2
                        .copyWith(color: theme.primaryColor),
                  )
                ])),
            SizedBox(height: 20),
            Text(dialogRequest.description,
                style:
                    theme.textTheme.subtitle2.copyWith(color: Colors.white70)),
            SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    await canLaunch(readMeLink)
                        ? await launch(readMeLink)
                        : SnackbarService().showSnackbar(message: "Could not load Url");
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Read More',
                        style: theme.textTheme.subtitle2
                            .copyWith(color: theme.primaryColor),
                      ),
                      Icon(Icons.double_arrow_sharp, size: 20,)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Connect with me:",
                style:
                    theme.textTheme.subtitle2.copyWith(color: Colors.white70)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SocialHandleWidget(
                  widget: Container(
                    width: 20,
                    height: 20,
                    child: Center(
                        child: Text('in',
                            style: theme.textTheme.subtitle2
                                .copyWith(color: Colors.white))),
                    decoration: BoxDecoration(
                        color: Color(0xff0A66C2),
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                  handleName: "LinkedIn",
                  handleUrl: linkedInProfileUrl,
                ),
                SocialHandleWidget(
                  widget: Container(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset("assets/images/ic_github.svg"),
                  ),
                  handleName: "GitHub",
                  handleUrl: githubProfileUrl,
                ),
                SocialHandleWidget(
                  widget: Container(
                    width: 20,
                    height: 17,
                    decoration: BoxDecoration(
                        color: Color(0xffFF0000),
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Center(
                        child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 13,
                    )),
                  ),
                  handleName: "YouTube",
                  handleUrl: youtubeChannelUrl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SocialHandleWidget extends StatelessWidget {
  final Widget widget;
  final String handleName;
  final String handleUrl;

  SocialHandleWidget({Key key, this.widget, this.handleName, this.handleUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await canLaunch(handleUrl)
            ? await launch(handleUrl)
            : SnackbarService().showSnackbar(message: "Could not load Url");
      },
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        widget,
        SizedBox(width: 5),
        Text(handleName,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white70, letterSpacing: 0.5))
      ]),
    );
  }
}
