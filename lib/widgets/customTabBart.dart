import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../utils/widget_utils.dart';

class CustomTabBar extends StatefulWidget {
  final double height;
  final double width;
  final String tab1;
  final String tab2;
  const CustomTabBar(
      {required this.height,
      required this.width,
      required this.tab1,
      required this.tab2});
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: scaleH(widget.height, context),
      width: scaleW(widget.width, context),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xffF0F0F8),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            30,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff4552CB).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 18,
              offset: Offset(0, 3),
            ),
          ],
          color: AppColors.violet,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            child: Text(
              widget.tab1,
              style: GoogleFonts.encodeSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 20 / 16,
              ),
            ),
          ),
          Tab(
            child: Text(
              widget.tab2,
              style: GoogleFonts.encodeSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 20 / 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
