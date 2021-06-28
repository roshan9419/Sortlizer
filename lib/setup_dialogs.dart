import 'package:flutter/material.dart';
import 'package:sorting_visualization/app/locator.dart';
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
    )
  };
  dialogService.registerCustomDialogBuilders(builders);
}