import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/colors.dart';

class CustomTextformfield extends StatelessWidget {
  final String text;
  const CustomTextformfield({required this.text});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightgrey2,
            width: 1.5,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightgrey2, width: 2),
        ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.headline6?.apply(
                color: AppColors.gray,
              ),
        ),
      ),
    );
  }
}
