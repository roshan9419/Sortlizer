import 'package:flutter/material.dart';
import 'package:sorting_visualization/app/locator.dart';
import 'package:sorting_visualization/ui/dialogs/about_app_dialog.dart';
import 'package:sorting_visualization/ui/dialogs/custom_array_size_dialog.dart';
import 'package:sorting_visualization/ui/dialogs/custom_input_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import 'datamodels/dialogType.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();
  var builders = {
    DialogType.CUSTOM_INPUT: (context, dialogRequest, completer) => Dialog(
      child: CustomInputDialog(
        dialogRequest: dialogRequest,
        onDialogTap: completer,
      ),
    ),
    DialogType.CUSTOM_ARRAY_SIZE: (context, dialogRequest, completer) => Dialog(
      child: CustomArraySizeDialog(
        dialogRequest: dialogRequest,
        onDialogTap: completer,
      ),
    ),
    DialogType.ABOUT_APP: (context, dialogRequest, completer) => Dialog(
      child: AboutAppDialog(
        dialogRequest: dialogRequest,
        onDialogTap: completer,
      ),
    )
  };
  dialogService.registerCustomDialogBuilders(builders);
}