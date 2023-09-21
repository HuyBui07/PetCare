import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class TimeCard extends StatefulWidget {
  final String time;

  const TimeCard({super.key, required this.time});

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Container(
        height: scaleH(35, context),
        width: scaleW(70, context),
        decoration: BoxDecoration(
            color: const Color(0xFFF0F0F8),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            widget.time,
            style: AppTheme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold, height: 1.2),
          ),
        ),
      ),
    );
  }
}
