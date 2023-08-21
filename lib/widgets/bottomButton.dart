import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class BottomButtom extends StatelessWidget {
  String label;
  BottomButtom(this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: scaleH(46, context),
        width: scaleW(280, context),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff4552CB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scaleW(24, context)),
            ),
          ),
          onPressed: () {},
          child: Text(
            label,
            style: Theme.of(context).textTheme.button!.apply(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
