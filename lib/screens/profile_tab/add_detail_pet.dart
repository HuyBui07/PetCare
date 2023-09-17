import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:petcare_search/pets/addpet_args.dart';
import 'package:petcare_search/pets/pet.dart';
import 'package:petcare_search/pets/pet_data.dart';
import 'package:petcare_search/pets/size.dart';
import 'package:petcare_search/screens/profile_tab/petPro5_Screen.dart';
import 'package:petcare_search/screens/pickImageModal.dart';
import 'package:petcare_search/users/gender.dart';
import 'package:petcare_search/utils/addPetDetail/cupertino_switch.dart';
import 'package:petcare_search/utils/addPetDetail/textFormField.dart';
import 'package:petcare_search/utils/addPetDetail/violetButton.dart';
import 'package:petcare_search/widgets/bottomButton.dart';
import 'package:petcare_search/widgets/dialog_custom.dart';
import 'package:petcare_search/widgets/gender_widget.dart';
import 'package:petcare_search/widgets/pet_species_dialog.dart';
import 'package:petcare_search/widgets/textform_dialog.dart';
import 'package:petcare_search/widgets/textformfield_widget.dart';
import '../../constants/colors.dart';
import '../../utils/widget_utils.dart';

import '../../utils/pet_events_list.dart';

class AddDetailPet extends StatefulWidget {
  final AddPetArgs args;

  const AddDetailPet({required this.args, super.key});
  @override
  State<AddDetailPet> createState() => _AddDetailPetState();
}

class _AddDetailPetState extends State<AddDetailPet> {
  late MyPet _pet;
  String _displaySize = 'Other';
  bool _isUploading = false;
  bool _isClosed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pet = widget.args.myPet ??
        MyPet(
            '',
            '',
            '',
            'Select',
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
    sizes.forEach((size) {
      if (size.values.first == _pet.size) {
        _displaySize = size.keys.toString().replaceAll(RegExp(r'[^\w\s]+'), '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Unsaved Changes",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      content: const Text(
                          "Are you sure to leave?\nChanges you made will be not save."),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Leave"),
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _isClosed = true;
                            });
                            //Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }).then((value) => _isClosed ? Navigator.pop(context) : null);
            },
            icon: const Icon(Icons.arrow_back, color: AppColors.violet)),
        centerTitle: true,
        title: Text(
          'Add pet detail',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          widget.args.type != 'add'
              ? TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.headline6?.apply(
                          color: AppColors.violet,
                        ),
                  ),
                )
              : Container()
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: scaleH(30, context),
              ),
              SizedBox(
                height: scaleH(112, context),
                width: scaleH(112, context),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _isUploading
                        ? const Center(child: CircularProgressIndicator())
                        : Positioned(
                            top: 10,
                            child: CircleAvatar(
                              radius: scaleH(50, context),
                              foregroundImage: _pet.imgPath == ''
                                  ? const AssetImage(
                                          'assets/imgs/petPro5Imgs/default_img.jpg')
                                      as ImageProvider
                                  : NetworkImage(_pet.imgPath),
                            ),
                          ),
                    Positioned(
                      right: 10,
                      top: 0,
                      child: Container(
                        height: scaleH(30, context),
                        width: scaleH(30, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xff4596EA),
                              Color(0xff4552CB),
                            ],
                          ),
                        ),
                        child: IconButton(
                          iconSize: scaleH(16, context),
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Wrap(
                                children: [
                                  buildModal(
                                      Icons.camera, 'Take a photo', 'camera'),
                                  buildModal(
                                      Icons.photo, 'Choose a photo', 'gallery')
                                ],
                              );
                            },
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context), top: scaleH(32, context)),
                child: Row(
                  children: [
                    Text(
                      'General\ninformation',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context), right: scaleH(20, context)),
                  child: TextFormFieldCustom(
                      "Pet's name", _pet.name, false, false, true,
                      onChanged: (String value) => setState(() {
                            _pet.name = value;
                          }),
                      onTap: () {})),
              Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context), right: scaleH(20, context)),
                  child: TextFormDialog(
                      'Species of your pet', _pet.species, true, onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      scaleW(15, context))),
                              title: Text(
                                'Species List',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              content: PetDialog(
                                  type: 'species',
                                  onTap: (String value) =>
                                      _updateSpecies(value)));
                        });
                  })),

              Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context), right: scaleH(20, context)),
                  child: TextFormFieldCustom(
                      "Breed", _pet.breed, false, false, false,
                      onChanged: (String value) => setState(() {
                            _pet.breed = value;
                          }),
                      onTap: () {})),
              Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context), right: scaleH(20, context)),
                  child: TextFormDialog('Size (optional)', _displaySize, false,
                      onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      scaleW(15, context))),
                              title: Text(
                                'Size List',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              content: PetDialog(
                                  type: 'size',
                                  onTap: (Map<String, PetSize> value) =>
                                      _updateSizes(value)));
                        });
                  })),
              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context), top: scaleH(24, context)),
                child: Row(
                  children: [
                    Text(
                      "Gender",
                      style: Theme.of(context).textTheme.headline6?.apply(
                            color: AppColors.gray,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    right: scaleH(20, context),
                    top: scaleH(13, context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    genderWidget(
                      label: 'Male',
                      icon: Icons.male,
                      isSelected: _pet.gender == Gender.male ? true : false,
                      onPressed: () {
                        setState(() {
                          _pet.gender = Gender.male;
                          //_changeGender = true;
                        });
                      },
                    ),
                    genderWidget(
                      label: 'Female',
                      icon: Icons.female,
                      isSelected: _pet.gender == Gender.female ? true : false,
                      onPressed: () {
                        setState(() {
                          _pet.gender = Gender.female;
                          //_changeGender = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: scaleW(20, context),
                      right: scaleH(20, context),
                      top: scaleH(20, context)),
                  child: TextFormDialog(
                      'Date of birth',
                      DateFormat('dd/MM/yyyy').format(_pet.dob),
                      false, onTap: () {
                    _selectDate(context);
                  })),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(37, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Neutered',
                  filter: _pet.isneutered,
                  onChange: (bool value) => setState(() {
                    _pet.isneutered = value;
                  }),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(24, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Vaccinated',
                  filter: _pet.isvaccinated,
                  onChange: (bool value) => setState(() {
                    _pet.isvaccinated = value;
                  }),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(24, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Friendly with dogs',
                  filter: _pet.isfwd,
                  onChange: (bool value) => setState(() {
                    _pet.isfwd = value;
                  }),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(24, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Friendly with cats',
                  filter: _pet.isfwc,
                  onChange: (bool value) => setState(() {
                    _pet.isfwc = value;
                  }),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(24, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Friendly with kids <10 years',
                  filter: _pet.isfwkl,
                  onChange: (bool value) => setState(() {
                    _pet.isfwkl = value;
                  }),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(24, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Friendly with kids >10 years',
                  filter: _pet.isfwkm,
                  onChange: (bool value) => setState(() {
                    _pet.isfwkm = value;
                  }),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(24, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Microchipped',
                  filter: _pet.ismicrochipped,
                  onChange: (bool value) => setState(() {
                    _pet.ismicrochipped = value;
                  }),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(24, context),
                    right: scaleH(20, context)),
                child: CusCupertinoswitch(
                  text: 'Purebred',
                  filter: _pet.ispurebred,
                  onChange: (bool value) => setState(() {
                    _pet.ispurebred = value;
                  }),
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child: TextFormFieldCustom("Pet’s nursery name (optional)",
                      _pet.nursename, false, false, false,
                      onChanged: (String value) => setState(() {
                            _pet.nursename = value;
                          }),
                      onTap: () {})),

              Padding(
                padding: EdgeInsets.only(
                  left: scaleH(20, context),
                  top: scaleH(32, context),
                ),
                child: Row(
                  children: [
                    Text(
                      'Reminders',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: scaleH(20, context),
                  top: scaleH(14, context),
                ),
                child: Row(
                  children: [
                    Text(
                      'Add vaccines, haircuts, pills, estrus, etc. and\nyou will receive notifications for the next\nevent.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: scaleW(20, context),
                    right: scaleW(20, context),
                    top: scaleH(24, context)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF0F0F8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.violet.withOpacity(0.09),
                            spreadRadius: 2,
                            blurRadius: 50,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      width: 140,
                      height: 150,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff4552CB).withOpacity(0.23),
                                    spreadRadius: 5,
                                    blurRadius: 17,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color(0xff4596EA),
                                    Color(0xff4552CB),
                                  ],
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  weight: 5,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Add event',
                              style: GoogleFonts.encodeSans(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF070821),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 150,
                        child: ListItem(title: [
                          'Measles vaccine',
                          'Measles vaccine',
                          'Measles vaccine',
                        ]),
                      ),
                    ),
                  ],
                ),
              ),

              //nút save

              Padding(
                padding: EdgeInsets.only(
                  top: scaleH(24, context),
                ),
                child: BottomButtom('Save', () async {
                  if (_checkValue(_pet)) {
                    try {
                      widget.args.type == 'add'
                          ? await addPet(_pet)
                              .then((value) => print('pet added'))
                          : await updatePet(_pet)
                              .then((value) => print('pet updated'));
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const DialogCustom(
                                'Your informaton is saved!', '');
                          });
                      Navigator.of(context).pop();
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DialogCustom(e.toString(), 'Error');
                          });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogCustom(
                              "Your pet's information is empty", '');
                        });
                  }
                }),
              ),
              SizedBox(
                height: scaleH(20, context),
              )
            ],
          ),
        ),
      ),
    );
  }

  _updateSpecies(String value) {
    setState(() {
      _pet.species = value;
    });
  }

  _updateSizes(Map<String, PetSize> value) {
    setState(() {
      _displaySize = value.keys.toString().replaceAll(RegExp(r'[^\w\s]+'), '');
      _pet.size = value[_displaySize]!;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _pet.dob,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _pet.dob) {
      setState(() {
        _pet.dob = picked;
      });
    }
  }

  bool _checkValue(MyPet mp) {
    if (mp.name == '' || mp.species == 'Select' || mp.gender == Gender.other) {
      return false;
    }
    return true;
  }

  Widget buildModal(IconData ic, String text, String type) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          ic,
          color: AppColors.violet,
        ),
        title: Text(text),
        onTap: () async {
          Navigator.of(context).pop();

          await _pickImage(type);
        },
      ),
    );
  }

  _pickImage(String src) async {
    try {
      setState(() {
        _isUploading = true;
      });
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: src == 'gallery' ? ImageSource.gallery : ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('PetImages')
            .child(pickedFile.name);

        final UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));

        await uploadTask.whenComplete(() => setState(() {
              _isUploading = false;
            }));
        final temp = await storageRef.getDownloadURL();
        setState(() {
          _pet.imgPath = temp;
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogCustom(e.toString(), 'Error');
          });
    }
  }
}
