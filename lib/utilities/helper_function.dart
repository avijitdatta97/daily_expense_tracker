import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, String actionText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      showCloseIcon: true,
      action: SnackBarAction(
        label: actionText,
        onPressed: () {
          showSnackBar(context, title, actionText);
        },
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showAlertDialog(BuildContext context, String title, String contentText, String cancelLabel, String doneLabel, Color cancelColor, Color doneColor) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(contentText),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelLabel, style: TextStyle(color: cancelColor),),
          ),
          TextButton(onPressed: () {}, child: Text(doneLabel, style: TextStyle(color: doneColor),)),
        ],
      );
    },
  );
}

void showTextInputDialog(BuildContext context, String title, String hintLabel, String cancelLabel, String doneLabel, Color cancelColor, Color doneColor){
  final TextEditingController textEditingController = TextEditingController();
   showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(title),
      content: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintLabel,
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(cancelLabel, style: TextStyle(color: cancelColor),),
        ),
        TextButton(onPressed: () {}, child: Text(doneLabel, style: TextStyle(color: doneColor),)),
      ],
    );
  });
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good Afternoon';
  } else if (hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}