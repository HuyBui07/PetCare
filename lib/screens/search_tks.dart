import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/home_screen.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class SearchThanks extends StatelessWidget {
  const SearchThanks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1,
                  colors: [Color(0xFF4596EA), Color(0xFF4552CB)])),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/iconsvg/tick.svg',
              ),
              SizedBox(
                height: scaleH(100, context),
              ),
              Text(
                'Your appointment\nhas been booked',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .apply(color: Colors.white),
              ),
              SizedBox(
                height: scaleH(20, context),
              ),
              Text(
                'Vasilenko Oksana will be waiting\nfor you and your pet',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .apply(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: scaleH(20, context),
              ),
              Container(
                height: scaleH(32, context),
                width: scaleW(213, context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(scaleW(18, context)),
                    color: const Color(0xff472DA4).withOpacity(0.6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/iconsvg/icon clock.svg',
                      colorFilter: ColorFilter.mode(
                          AppColors.lightgrey2, BlendMode.srcIn),
                    ),
                    Text(
                      'Wed 9 Sep at 10:30 am',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .apply(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: scaleH(10, context),
              ),
              Text(
                '+ Add appointment to calendar',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .apply(color: Colors.white),
              ),
              SizedBox(
                height: scaleH(100, context),
              ),
              // Container(
              //   height: scaleH(46, context),
              //   width: scaleW(240, context),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(
              //         scaleW(24, context),
              //       ),
              //       color: Colors.transparent,
              //       border: Border.all(
              //           width: scaleW(2, context), color: Colors.white)),
              //   child: Center(
              //     child: Text(
              //       'Go to my appointments',
              //       style: Theme.of(context)
              //           .textTheme
              //           .button!
              //           .apply(color: Colors.white),
              //     ),
              //   ),
              // )
              Container(
                height: scaleH(46, context),
                width: scaleW(240, context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      scaleW(24, context),
                    ),
                    color: Colors.transparent,
                    border: Border.all(
                        width: scaleW(2, context), color: Colors.white)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        scaleW(24, context),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteGenerator.main,
                        arguments: 1);
                  },
                  child: Text(
                    'Go to my appointments',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .apply(color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('showModalBottomSheet'),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Text('Modal BottomSheet'),
                              ElevatedButton(
                                child: const Text('Close BottomSheet'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ))),
    );
  }
}
