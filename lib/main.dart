import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balls',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF070821),
              //42.5px
              height: 1.25,
            ),
            headline2: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFCF6F),
              //42.5px
              height: 1.25,
            ),
            bodyText1: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF070821),
              //16px
              height: 1.45,
              letterSpacing: 0.4,
              //font encode sans
              fontFamily: 'EncodeSans',
            ),
          )),
      home: SearchMain(),
    );
  }
}

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

  //Grid item widget. Icon takes image path
  Widget _buildGridItem(String label, String iconPath) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
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
        unselectedItemColor: NavigationBarColor.unselectedItemColor,
        selectedItemColor: NavigationBarColor.selectedItemColor,
        unselectedFontSize: NavigationBarColor.unselectedFontSize,
        selectedFontSize: NavigationBarColor.selectedFontSize,
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
              NavigationBarColor.gradientStartColor,
              NavigationBarColor.gradientEndColor,
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
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline1,
                children: <TextSpan>[
                  TextSpan(text: 'What are you looking for , '),
                  TextSpan(
                    text: '$userName ?',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            //Grid view currrently contains 9 items, each with its own icon and label that will be used to navigate to a new page. Where icon takes from assets\mainSearchIcon
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  //path: adoption.png, boarding.png, date.png, dog walking.png,grooming.png, other.png, taxi.png, vet.png, training.png
                  _buildGridItem('Veterinary', 'assets/mainSearchIcon/vet.png'),
                  _buildGridItem(
                      'Grooming', 'assets/mainSearchIcon/grooming.png'),
                  _buildGridItem(
                      'Pet Boarding', 'assets/mainSearchIcon/boarding.png'),
                  _buildGridItem(
                      'Adoption', 'assets/mainSearchIcon/adoption.png'),
                   _buildGridItem(
                      'Dog Walking', 'assets/mainSearchIcon/dog walking.png'),
                      _buildGridItem(
                      'Training', 'assets/mainSearchIcon/training.png'),
                       _buildGridItem('Pet Taxi', 'assets/mainSearchIcon/taxi.png'),
                  _buildGridItem('Pet Date', 'assets/mainSearchIcon/date.png'),
                 

                  _buildGridItem('Other', 'assets/mainSearchIcon/other.png'),
                 

                  
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class NavigationBarColor {
  //gradient bg
  static const Color gradientStartColor = Color(0xFFF9F8FD);
  static const Color gradientEndColor = Color(0xFFFFFF);

  static const Color unselectedItemColor = Colors.grey;
  static const Color selectedItemColor = Color(0xFF4552CB);

  static const TextStyle unselectedLabelStyle = TextStyle(
    color: Colors.grey,
  );
  static const TextStyle selectedLabelStyle =
      TextStyle(color: selectedItemColor);
  static const double unselectedFontSize = 14.0;
  static const double selectedFontSize = 14.0;
}
