import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/pets/addpet_args.dart';
import 'package:petcare_search/pets/pet.dart';
import 'package:petcare_search/pets/pet_data.dart';
import 'package:petcare_search/pets/size.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/users/gender.dart';
import 'package:petcare_search/users/user_data.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/buttonLightStyle.dart';
import 'package:petcare_search/widgets/petPro5Card.dart';

AddPetArgs args = AddPetArgs(null, 'add');

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
                  onPressed: () => {
                    Navigator.pushNamed(context, RouteGenerator.petdetail,
                        arguments: args),
                  },
                  icon: const Icon(Icons.add),
                  color: AppColors.violet,
                )),
          ]),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Pets')
              .doc(GlobalData.email)
              .collection('Pets')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final petSnapshot = snapshot.data?.docs;
            if (petSnapshot!.isEmpty) {
              return ButtonLight(
                'Add another pet',
                Icons.add,
                onPressed: () => Navigator.pushNamed(
                    context, RouteGenerator.petdetail,
                    arguments: args),
              );
            }
            return Container(
              color: AppColors.lightgray,
              // child: ListView.builder(
              //     padding: const EdgeInsets.only(bottom: 20),
              //     itemCount: petList.length + 1,
              //     itemBuilder: (BuildContext context, int index) {
              //       return index == petList.length
              //           ? ButtonLight(
              //               'Add another pet',
              //               Icons.add,
              //               onPressed: () => Navigator.pushNamed(
              //                   context, RouteGenerator.addpet,
              //                   arguments: args),
              //             )
              //           : PetProfileCard(pet: petList[index]);
              //     }),
              child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: petSnapshot.length + 1,
                  itemBuilder: (context, index) {
                    return index == petSnapshot.length
                        ? ButtonLight(
                            'Add another pet',
                            Icons.add,
                            onPressed: () => Navigator.pushNamed(
                                context, RouteGenerator.petdetail,
                                arguments: args),
                          )
                        : PetProfileCard(
                            petSnapshot: petSnapshot[index],
                          );
                  }),
            );
          }),
    );
  }
}
