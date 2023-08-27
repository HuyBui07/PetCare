import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          Navigator(
            initialRoute: RouteGenerator.search,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
          Navigator(
            initialRoute: RouteGenerator.appoitment,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
          Navigator(
            initialRoute: RouteGenerator.explore,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
          Navigator(
            initialRoute: RouteGenerator.pro5,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        ],
        onPageChanged: (page) {
          setState(() {
            _currentIndex = page;
          });
        },
      ),
      //Bottom tab menu
      bottomNavigationBar: SizedBox(
        height: scaleH(83, context),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          showUnselectedLabels: true,
          unselectedItemColor: NavigationBarStyle.unselectedItemColor,
          selectedItemColor: NavigationBarStyle.selectedItemColor,
          unselectedFontSize: NavigationBarStyle.unselectedFontSize,
          selectedFontSize: NavigationBarStyle.selectedFontSize,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  curve: Curves.decelerate,
                  duration: Duration(milliseconds: 300));
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.schedule,
              ),
              label: 'Appointment',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
