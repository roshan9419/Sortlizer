import 'package:flutter/material.dart';
import 'package:sorting_visualization/ui/ui_theme.dart';
import 'package:sorting_visualization/ui/views/settings_viewmodel.dart';
import 'package:sorting_visualization/ui/widgets/custom_round_btn.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => SettingsViewModel(),
        onModelReady: (model) {
          model.getInitialized();
        },
        builder: (context, model, child) => Container(
              decoration: BoxDecoration(gradient: darkGradient),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 2),
                        child: Row(
                          children: [
                            CustomRoundButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: lightGrayColor,
                                size: 18,
                              ),
                              btnColor: darkBtnColor2,
                              onTap: model.onBackBtnPressed,
                            ),
                            Spacer(),
                            Text(
                              "Settings",
                              style: theme.textTheme.subtitle2
                                  ?.copyWith(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(width: 30),
                            Spacer()
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "General",
                              style: theme.textTheme.caption?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 10, top: 5, bottom: 5),
                                child: Text(
                                  'Show Sorting History',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              Switch(
                                  value: model.showSortingHistory,
                                  onChanged: model.updateShowSortingHistory,
                                  activeColor: Theme.of(context).primaryColor,
                                  inactiveTrackColor: Colors.grey[800]),
                            ],
                          ),
                          ActionItem(
                            "Sorting Sound",
                            model.sortingSoundsEnabled ? "Enabled" : "Disabled",
                            onTap: model.updateSortingSounds,
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "App",
                              style: theme.textTheme.caption?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryColor),
                            ),
                          ),
                          ActionItem(
                            "App Version",
                            model.isBusy ? "-" : model.appVersion
                          ),
                          ActionItem(
                            "Source Code",
                            "View the GitHub repository",
                            onTap: model.showSourceCode,
                          ),
                          ActionItem(
                            "Reset App",
                            "Clear the data and restore settings",
                            onTap: model.resetApp,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

class ActionItem extends StatelessWidget {
  const ActionItem(this.title, this.subtitle, {Key? key, this.onTap})
      : super(key: key);
  final String title;
  final String subtitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      title: Text(title,
          style: theme.textTheme.subtitle2?.copyWith(color: Colors.white)),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.caption
            ?.copyWith(color: theme.colorScheme.secondary),
      ),
      onTap: onTap,
    );
  }
}
