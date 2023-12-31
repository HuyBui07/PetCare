import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petcare_search/screens/splash_screens/welcome1.dart';
import 'package:petcare_search/screens/splash_screens/welcome2.dart';
import 'package:petcare_search/screens/splash_screens/welcome3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatelessWidget {
  PageController _controller = PageController();

  Welcome({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Welcome1(
                onPressed: () {
                  _controller.animateToPage(1,
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 300));
                },
              ),
              Welcome2(
                onPressed: () {
                  _controller.animateToPage(2,
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 300));
                },
              ),
              Welcome3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.2),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Color(0xFFF1A852),
                dotColor: Color(0XFFE6E6F6),
                dotHeight: 9,
                dotWidth: 9,
                spacing: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
