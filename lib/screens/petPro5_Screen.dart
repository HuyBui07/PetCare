import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/buttonLightStyle.dart';
import 'package:petcare_search/widgets/petPro5Card.dart';

class Pet {
  String name;
  String breed;
  String ImagePath;
  Pet(this.name, this.breed, this.ImagePath);
}

List<Pet> petList = [
  Pet('Troy', 'Toy terrier', 'ImagePath'),
  Pet('Troy', 'Toy terrier', 'ImagePath'),
  Pet('Troy', 'Toy terrier', 'ImagePath'),
  Pet('Troy', 'Toy terrier', 'ImagePath'),
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
        leading: const Icon(
          Icons.arrow_back,
          color: AppColors.violet,
        ),
        actions: [
          GestureDetector(
            child: Row(children: [
              const Icon(
                Icons.add,
                color: AppColors.violet,
              ),
              SizedBox(
                width: scaleW(20, context),
              )
            ]),
          ),
        ],
      ),
      body: Container(
        color: AppColors.lightgray,
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: petList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index == petList.length
                  ? const ButtonLight('Add another pet', Icons.add)
                  : PetProfileCard();
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        height: scaleH(83, context),
        color: Colors.amber,
        // child: Icon(Icons.home),
      ),
    );
  }
}
