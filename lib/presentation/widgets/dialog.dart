import 'package:flutter/material.dart';

import '../resources/style_manager.dart';

Future<void> displayTextInputDialog(BuildContext contextDialog,
    {required String title,
    required String titleActionLeft,
    required String titleActionRight,
    String? hintText,
    ValueChanged<String>? onChange,
    TextEditingController? textFieldController,
    VoidCallback? actionAgree,
    VoidCallback? actionDegree}) async {
  return showDialog(
      context: contextDialog,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            onChanged: onChange,
            controller: textFieldController,
            minLines: 5,
            maxLines: 10,
            decoration: InputDecoration(hintText: hintText),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: actionDegree,
              child: Text(titleActionLeft,
                  style: getMediumStyle(
                      color: Theme.of(contextDialog).primaryColor)),
            ),
            TextButton(
              onPressed: actionAgree,
              child: Text(titleActionRight,
                  style: getMediumStyle(
                      color: Theme.of(contextDialog).primaryColor)),
            ),
          ],
        );
      }).then((exit) {
    textFieldController?.text = "";
  });
}

Future<void> displayDialogTwoAction(BuildContext contextDialog,
    {required String title,
    required String message,
    required String titleActionLeft,
    required String titleActionRight,
    VoidCallback? actionRight,
    VoidCallback? actionLeft}) async {
  showDialog(
    context: contextDialog,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: actionLeft,
            child: Text(titleActionLeft,
                style: getMediumStyle(color: Theme.of(context).primaryColor)),
          ),
          TextButton(
            onPressed: actionRight,
            child: Text(titleActionRight,
                style: getMediumStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      );
    },
  );
}

Future<void> displayDialogOneAction(
  BuildContext contextDialog, {
  required String title,
  required String message,
  required String titleAction,
  VoidCallback? actionCallback,
}) async {
  showDialog(
    context: contextDialog,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: actionCallback,
            child: Text(titleAction,
                style: getMediumStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      );
    },
  );
}
