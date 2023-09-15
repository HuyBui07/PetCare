import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CusCupertinoswitch extends StatefulWidget {
  final Function onChange;
  final String text;
  bool filter;

  CusCupertinoswitch(
      {super.key,
      required this.text,
      required this.filter,
      required this.onChange});

  @override
  State<CusCupertinoswitch> createState() => _CusCupertinoswitchState();
}

class _CusCupertinoswitchState extends State<CusCupertinoswitch> {
  // bool filter = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Spacer(),
        CupertinoSwitch(
          value: widget.filter,
          onChanged: (isChecked) {
            widget.onChange(isChecked);
          },
          trackColor: Color(0xffF5F5F5),
          activeColor: Color(0xff4552CB),
        ),
      ],
    );
  }
}
