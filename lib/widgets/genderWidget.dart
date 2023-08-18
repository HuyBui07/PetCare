import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class genderWidget extends StatelessWidget {
  final String gender;
  final String selected;
  final VoidCallback? onPressed;

  const genderWidget(
      {super.key,
      this.onPressed,
      required this.gender,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(scaleW(20, context)),
          boxShadow: selected == gender
              ? [
                  BoxShadow(
                    color: const Color(0xff4552CB).withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 13,
                    offset: Offset(0, 4),
                  ),
                  BoxShadow(
                    color: const Color(0xff2A2049).withOpacity(0.09),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ]
              : null),
      width: scaleW(163, context),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          gender == 'Male' ? Icons.male : Icons.female,
          color: selected == gender ? Colors.white : AppColors.violet,
        ),
        label: Text(
          gender,
          style: Theme.of(context).textTheme.headline6!.apply(
                color: selected == gender ? Colors.white : AppColors.violet,
              ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: selected == gender ? AppColors.violet : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: selected == gender
                    ? AppColors.violet
                    : const Color(0xFFE4E3F3),
                width: 1.5),
          ),
        ),
      ),
    );
  }
}
