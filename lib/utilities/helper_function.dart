import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, String actionText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      showCloseIcon: true,
      action: SnackBarAction(label: actionText, onPressed: (){
        showSnackBar(context, title, actionText);
      }),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
