import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/pets/addpet_args.dart';
import 'package:petcare_search/pets/pet.dart';
import 'package:petcare_search/pets/pet_data.dart';
import 'package:petcare_search/pets/size.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/petPro5_Screen.dart';
import 'package:petcare_search/users/gender.dart';
import 'package:petcare_search/users/user_data.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/dialog_custom.dart';

class PetProfileCard extends StatelessWidget {
  //final MyPet pet;
  final QueryDocumentSnapshot<Object?> petSnapshot;
  const PetProfileCard({super.key, required this.petSnapshot});

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
                  onPressed: () async {
                    AddPetArgs addAgrs = AddPetArgs(null, 'edit');
                    try {
                      MyPet args = MyPet(
                          '',
                          '',
                          '',
                          '',
                          '',
                          PetSize.other,
                          Gender.other,
                          DateTime.now(),
                          false,
                          false,
                          false,
                          false,
                          false,
                          false,
                          false,
                          false,
                          '');
                      args.id = petSnapshot.id;
                      args.imgPath = petSnapshot['imgPath'];
                      args.name = petSnapshot['name'];
                      args.species = petSnapshot['species'];
                      args.breed = petSnapshot['breed'];
                      args.size = parseSize(petSnapshot['size'], args.size);
                      args.gender =
                          parseGender(petSnapshot['gender'], args.gender);
                      args.dob = (petSnapshot['dob'] as Timestamp).toDate();
                      args.isneutered = petSnapshot['isNeutered'];
                      args.isvaccinated = petSnapshot['isVaccinated'];
                      args.isfwd = petSnapshot['isFwd'];
                      args.isfwc = petSnapshot['isFwc'];
                      args.isfwkl = petSnapshot['isFwkl'];
                      args.isfwkm = petSnapshot['isFwkm'];
                      args.ismicrochipped = petSnapshot['isMicrochipped'];
                      args.ispurebred = petSnapshot['isPurebred'];
                      args.nursename = petSnapshot['nursename'];
                      addAgrs = AddPetArgs(args, 'edit');
                      Navigator.pushNamed(context, RouteGenerator.petdetail,
                          arguments: addAgrs);
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DialogCustom(e.toString(), 'Error');
                          });
                    }

                    //print('name pet ${widget.args.myPet?.name}');
                  },
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
            radius: scaleH(60, context),
            foregroundImage: petSnapshot['imgPath'] == ''
                ? const AssetImage('assets/imgs/petPro5Imgs/default_img.jpg')
                    as ImageProvider
                : NetworkImage(petSnapshot['imgPath']),
          ),
          SizedBox(
            height: scaleH(15, context),
          ),
          Text(
            petSnapshot['name'],
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            petSnapshot['breed'],
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .apply(color: AppColors.gray),
          ),
        ]));
  }
}
