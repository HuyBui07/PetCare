import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/appoinment_tab/appointmentScreen.dart';
import 'package:petcare_search/screens/explore_screen.dart';
import 'package:petcare_search/screens/search_tab/mainSearch.dart';
import 'package:petcare_search/screens/profile_tab/profile_Screen.dart';
import 'package:petcare_search/providers/auth_provider.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  int index;
  MainScreen({super.key, required this.index});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  late PageController _pageController;
  final List<Widget> _pages = <Widget>[
    SearchMain(),
    AppointmentScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _currentIndex = widget.index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            Navigator(
              initialRoute: RouteGenerator.search,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
            Navigator(
              initialRoute: RouteGenerator.appoitment,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
            //_pages[1],
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
        bottomNavigationBar: Provider.of<LogProvider>(context).loggedState !=
                false
            ? SizedBox(
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
                  items: const <BottomNavigationBarItem>[
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
              )
            : null);
  }
}
