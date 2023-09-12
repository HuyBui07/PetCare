import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/users/gender.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class genderWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onPressed;

  const genderWidget(
      {super.key,
      this.onPressed,
      required this.label,
      required this.icon,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(scaleW(20, context)),
          boxShadow: isSelected ? AppColors.boxShadow : null),
      width: scaleW(163, context),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isSelected ? Colors.white : AppColors.violet,
        ),
        label: Text(
          label,
          style: Theme.of(context).textTheme.headline6!.apply(
                color: isSelected ? Colors.white : AppColors.violet,
              ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? AppColors.violet : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: isSelected ? AppColors.violet : const Color(0xFFE4E3F3),
                width: 1.5),
          ),
        ),
      ),
    );
  }
}
