import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class DateCard extends StatefulWidget {
  final int date;
  final int dayOfTheWeek;

  const DateCard({super.key, required this.dayOfTheWeek, required this.date});

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> with TickerProviderStateMixin {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String dateConverter(int dotw) {
    switch (dotw) {
      case 2:
        return "Mon";
      case 3:
        return "Tue";
      case 4:
        return "Wed";
      case 5:
        return "Thu";
      case 6:
        return "Fri";
      case 7:
        return "Sat";
      case 8:
        return "Sun";
      default:
        return "?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: SizedBox(
        height: scaleH(72, context),
        width: scaleW(48, context),
        child: Center(
            child: Column(
          children: [
            _isSelected == true
                ? Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.violet,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 4,
                  ),
            const SizedBox(
              height: 4,
              width: double.infinity,
            ),
            SizedBox(
              height: scaleH(7, context),
            ),
            Text(
              widget.date.toString(),
              style: AppTheme.textTheme.displaySmall!.copyWith(
                color: const Color(0xFF4552CB),
              ),
            ),
            SizedBox(
              height: scaleH(6, context),
            ),
            Text(
              dateConverter(widget.dayOfTheWeek),
              style: AppTheme.textTheme.bodySmall,
            )
          ],
        )),
      ),
    );
  }
}
