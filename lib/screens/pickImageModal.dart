import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';

Widget buildModal2(
    IconData ic, String text, String type, BuildContext context, Future ft) {
  return Container(
    color: Colors.white,
    child: ListTile(
      leading: Icon(
        ic,
        color: AppColors.violet,
      ),
      title: Text(text),
      onTap: () async {
        Navigator.of(context).pop();

        //await _pickImage(type);
        await ft;
      },
    ),
  );
}
