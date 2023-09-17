import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, RouteGenerator.welcome);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1,
                  colors: [Color(0xFF4596EA), Color(0xFF4552CB)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: scaleW(194.42, context), top: scaleH(283.9, context)),
                child: Image.asset('assets/imgs/petFootprint/icon-5.png'),
              ),
              Container(
                margin: EdgeInsets.only(
                    //top: scaleH(336.17, context),
                    top: scaleH(10, context),
                    left: scaleW(167.58, context)),
                child: Image.asset('assets/imgs/petFootprint/icon-4.png'),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: scaleW(218.08, context), top: scaleH(20, context)),
                child: Image.asset('assets/imgs/petFootprint/icon-3.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: scaleW(169.39, context)),
                child: Image.asset('assets/imgs/petFootprint/icon-2.png'),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: scaleW(185.39, context), top: scaleH(20, context)),
                child: Image.asset('assets/imgs/petFootprint/icon-1.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: scaleW(127.17, context)),
                child: Image.asset('assets/imgs/petFootprint/icon.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
