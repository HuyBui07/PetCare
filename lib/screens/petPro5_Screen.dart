import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/buttonLightStyle.dart';
import 'package:petcare_search/widgets/petPro5Card.dart';

class Pet {
  String name;
  String breed;
  String imagePath;
  Pet(this.name, this.breed, this.imagePath);
}

List<Pet> petList = [
  Pet('Troy', 'Toy terrier', 'assets/imgs/petPro5Imgs/Troy_pet.jpg'),
  Pet('Troy1', 'Husky', 'assets/imgs/petPro5Imgs/husky_dog.jpg'),
  Pet('Troy2', 'Golden', 'assets/imgs/petPro5Imgs/golden_dog.jpg'),
  Pet('Troy3', 'Alaska', 'assets/imgs/petPro5Imgs/alaska_dog.jpg'),
];

class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.lightgray,
          elevation: 0,
          title: Text(
            'My Pets',
            style: Theme.of(context).textTheme.headline3,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.violet,
              )),
          actions: [
            SizedBox(
                width: scaleW(60, context),
                child: IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteGenerator.addpet),
                  icon: const Icon(Icons.add),
                  color: AppColors.violet,
                )),
          ]),

      body: Container(
        color: AppColors.lightgray,
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: petList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index == petList.length
                  ? const ButtonLight('Add another pet', Icons.add)
                  : PetProfileCard(pet: petList[index]);
            }),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   height: scaleH(83, context),
      //   color: Colors.amber,
      //   // child: Icon(Icons.home),
      // ),
    );
  }
}
