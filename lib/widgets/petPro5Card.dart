import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/screens/petPro5_Screen.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class PetProfileCard extends StatelessWidget {
  final Pet pet;
  const PetProfileCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: scaleH(279, context),
        margin: EdgeInsets.all(scaleW(20, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(scaleW(18, context)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: const Color(0xff2D368A).withOpacity(0.08),
                offset: const Offset(
                  4.0,
                  6.0,
                ),
                blurRadius: 28.0,
                spreadRadius: 0)
          ],
        ),
        child: Column(children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: scaleW(80, context),
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      shadowColor: MaterialStatePropertyAll(Colors.white),
                      elevation: MaterialStatePropertyAll(0)),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        color: AppColors.violet,
                      ),
                      Text('Edit',
                          style: Theme.of(context).textTheme.headline6?.apply(
                                color: AppColors.violet,
                              )),
                    ],
                  )),
            ),
          ),
          CircleAvatar(
            radius: scaleW(56, context),
            backgroundImage: AssetImage(pet.ImagePath),
          ),
          SizedBox(
            height: scaleH(10, context),
          ),
          Text(
            pet.name,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            pet.breed,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .apply(color: AppColors.gray),
          ),
        ]));
  }
}
