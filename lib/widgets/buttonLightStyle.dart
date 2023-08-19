import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class ButtonLight extends StatelessWidget {
  final String label;
  final IconData icon;
  const ButtonLight(this.label, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: scaleH(46, context),
        margin: EdgeInsets.symmetric(horizontal: scaleW(20, context)),
        width: scaleW(335, context),
        child: ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.lightgrey2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scaleW(10, context)),
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: AppColors.violet,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.button!.apply(
                      color: AppColors.violet,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
