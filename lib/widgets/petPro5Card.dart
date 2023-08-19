import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';

class PetProfileCard extends StatelessWidget {
  const PetProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: scaleH(279, context),
        margin: EdgeInsets.all(scaleW(20, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(scaleW(18, context)),
          color: Colors.yellow,
          boxShadow: [
            BoxShadow(
                color: const Color(0xff2D368A).withOpacity(0.0),
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
          Center(
            child: CircleAvatar(
              radius: scaleW(56, context),
              backgroundImage:
                  const AssetImage('assets/imgs/petPro5Imgs/Troy_pet.jpg'),
            ),
          )
        ]));
  }
}
