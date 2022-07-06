import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'datamodels/snackbarType.dart';

void setupSnackBarUi() {
  var snackBarService = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  snackBarService.registerSnackbarConfig(SnackbarConfig(
      backgroundColor: Color(0xff3A3A3A), messageColor: Colors.white));

  // Registers a config to be used when calling showCustomSnackbar
  snackBarService.registerCustomSnackbarConfig(
    variant: SnackBarType.DARK,
    config: SnackbarConfig(
      backgroundColor: Color(0xff3A3A3A),
      borderRadius: 0,
      messageColor: Colors.white,
      mainButtonTextColor: Color(0xffec3a45),
    ),
  );
}
