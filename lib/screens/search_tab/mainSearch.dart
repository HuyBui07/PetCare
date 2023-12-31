import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare_search/widgets/search_speciality.dart';

import '../../appStyle.dart';
import '../../users/user_data.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});
  final Color bakcgroundColor = const Color(0xFFF9F8FD);
  final Color iconColor = const Color(0xFF4552CB);

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  int currentIndex = 0;

  //List of grid items
  List<MainSearchGridItem> gridItems = [
    MainSearchGridItem(
      label: 'Veterinary',
      iconPath: 'assets/imgs/mainSearchIcon/vet.png',
      route: '/veterinary',
    ),
    MainSearchGridItem(
      label: 'Grooming',
      iconPath: 'assets/imgs/mainSearchIcon/grooming.png',
      route: '/',
    ),
    MainSearchGridItem(
      label: 'Pet Boarding',
      iconPath: 'assets/imgs/mainSearchIcon/boarding.png',
      route: '/',
    ),
    MainSearchGridItem(
      label: 'Adoption',
      iconPath: 'assets/imgs/mainSearchIcon/adoption.png',
      route: '/',
    ),
    MainSearchGridItem(
      label: 'Dog Walking',
      iconPath: 'assets/imgs/mainSearchIcon/dog walking.png',
      route: '/',
    ),
    MainSearchGridItem(
      label: 'Training',
      iconPath: 'assets/imgs/mainSearchIcon/training.png',
      route: '/',
    ),
    MainSearchGridItem(
      label: 'Pet Taxi',
      iconPath: 'assets/imgs/mainSearchIcon/taxi.png',
      route: '/',
    ),
    MainSearchGridItem(
      label: 'Pet Date',
      iconPath: 'assets/imgs/mainSearchIcon/date.png',
      route: '/',
    ),
    MainSearchGridItem(
      label: 'Other',
      iconPath: 'assets/imgs/mainSearchIcon/other.png',
      route: '/',
    ),
  ];

  //Grid item widget. Icon takes image path. Height and width are optional. Should be used along with grid view builder to scale the grid item size.
  Widget _buildGridItem(String label, TextStyle textStyle,
      [String iconPath = 'assets/imgs/mainSearchIcon/other.png',
      String route = '/',
      double height = 0.1,
      double width = 0.1,
      double borderRadiusFactor = 1.0]) {
    double borderRadius = 35 * borderRadiusFactor;

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),

      //effect

      onTap: () {
        if (route != '/') {
          if (route == '/veterinary') {
            showModalBottomSheet(
              useRootNavigator: true,
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              builder: (ctx) => SearchSpeciality(
                subContext: context,
              ),
            );
          } else {
            Navigator.pushNamed(context, route);
          }
        } else {
          //Alert dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text("This feature is not available yet."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            //White
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * height,
          width: MediaQuery.of(context).size.width * width,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  iconPath,
                  height: height * 0.5,
                  width: width * 0.5,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Build grid view, based on the number of items. Maximum height is 0.375 of the screen size, maximum width is 0.8 of the screen. Scale accordingly.
  //Each grid view item should have height and width based on how many items are in the grid view.
  //Always has 3 columns
  Widget _buildGridView() {
    int itemsCount = gridItems.length;
    int maxColumns = 3; // Maximum number of columns
    int defaultItemCount = 9; // Default number of items

    int columns = (itemsCount > defaultItemCount) ? maxColumns + 1 : maxColumns;

    double gridViewHeight = MediaQuery.of(context).size.height * 0.375;
    double gridViewWidth = MediaQuery.of(context).size.width * 0.8;

    double singleItemHeight = (gridViewHeight / columns).roundToDouble();
    double singleItemWidth = (gridViewWidth / columns).roundToDouble();

    double fontSizeFactor = 1.0;

    if (itemsCount > defaultItemCount) {
      fontSizeFactor = 0.7; // Adjust this factor as needed
    }

    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize:
              Theme.of(context).textTheme.bodyLarge!.fontSize! * fontSizeFactor,
        );

    return SizedBox(
      height: gridViewHeight,
      width: gridViewWidth,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: gridItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return _buildGridItem(
            gridItems[index].label,
            AppTheme.textTheme.bodySmall!,
            gridItems[index].iconPath,
            gridItems[index].route,
            singleItemHeight,
            singleItemWidth,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bakcgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        // gradient bg
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: widget.iconColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      //Bottom tab menu
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   showUnselectedLabels: true,
      //   unselectedItemColor: NavigationBarStyle.unselectedItemColor,
      //   selectedItemColor: NavigationBarStyle.selectedItemColor,
      //   unselectedFontSize: NavigationBarStyle.unselectedFontSize,
      //   selectedFontSize: NavigationBarStyle.selectedFontSize,
      //   type: BottomNavigationBarType.fixed,
      //   onTap: (index) {
      //     setState(() {
      //       currentIndex = index;
      //     });
      //   },
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.search,
      //       ),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.schedule,
      //       ),
      //       label: 'Appointment',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.explore,
      //       ),
      //       label: 'Explore',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.person,
      //       ),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              NavigationBarStyle.gradientStartColor,
              NavigationBarStyle.gradientEndColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0.0, 32, 0.0),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            //"What are you looking for $"username"?
            //Where the first part use h1headline and username use h2headline
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(GlobalData.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    return RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.displayLarge,
                        children: <TextSpan>[
                          const TextSpan(text: 'What are you looking for, '),
                          TextSpan(
                            text: '${data?['name']}?',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: Colors.orange),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            //Grid view currrently contains 9 items, each with its own icon and label that will be used to navigate to a new page. Where icon takes from assets\mainSearchIcon
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _buildGridView(),
          ]),
        ),
      ),
    );
  }
}

class MainSearchGridItem {
  final String label;
  final String iconPath;
  final String route;

  MainSearchGridItem(
      {required this.label, required this.iconPath, this.route = "/"});
}
