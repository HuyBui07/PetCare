import 'package:flutter/material.dart';

class DialogCustom extends StatelessWidget {
  const DialogCustom(this.err, this.title, {super.key});

  final String err, title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(err),
      actions: [
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    ;
  }
}
