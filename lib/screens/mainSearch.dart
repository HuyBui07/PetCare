import 'package:flutter/material.dart';

import '../appStyle.dart';

class SearchMain extends StatefulWidget {
  SearchMain({super.key});
  final Color bakcgroundColor = Color(0xFFF9F8FD);
  final Color iconColor = Color(0xFF4552CB);

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  int currentIndex = 0;
  String? userName = "Maria";

  //List of grid items
  List<MainSearchGridItem> gridItems = [
    MainSearchGridItem(
      label: 'Veterinary',
      iconPath: 'assets/imgs/mainSearchIcon/vet.png',
      route: '/',
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
          Navigator.pushNamed(context, route);
        } else {
          //Alert dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Alert"),
                content: Text("This feature is not available yet."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
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
              SizedBox(
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

    TextStyle textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize:
              Theme.of(context).textTheme.bodyText1!.fontSize! * fontSizeFactor,
        );

    return Container(
      height: gridViewHeight,
      width: gridViewWidth,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: gridItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return _buildGridItem(
            gridItems[index].label,
            AppTheme.textTheme.caption!,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        unselectedItemColor: NavigationBarStyle.unselectedItemColor,
        selectedItemColor: NavigationBarStyle.selectedItemColor,
        unselectedFontSize: NavigationBarStyle.unselectedFontSize,
        selectedFontSize: NavigationBarStyle.selectedFontSize,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
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

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
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
            Container(
              height: MediaQuery.of(context).size.height * 0.11,
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline1,
                  children: <TextSpan>[
                    TextSpan(text: 'What are you looking for, '),
                    TextSpan(
                      text: '$userName ?',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.orange),
                    ),
                  ],
                ),
              ),
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
