import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/colors.dart';

class CustomTextformfield extends StatefulWidget {
  final Function onChanged;
  final String text;
  final String value;
  const CustomTextformfield(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged});

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  late String _currentValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _currentValue = value;
        });
        widget.onChanged(_currentValue);
      },
      initialValue: widget.value,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightgrey2,
            width: 1.5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightgrey2, width: 2),
        ),
        label: Text(
          widget.text,
          style: Theme.of(context).textTheme.headline6?.apply(
                color: AppColors.gray,
              ),
        ),
      ),
    );
  }
}
