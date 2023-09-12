import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/screens/pickImageModal.dart';
import 'package:petcare_search/users/gender.dart';
import 'package:petcare_search/users/user_data.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/change_email_dialog.dart';
import 'package:petcare_search/widgets/dialog_custom.dart';
import 'package:petcare_search/widgets/gender_widget.dart';
import 'package:petcare_search/widgets/textformfield_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  bool _isClosed = false;
  bool _isUploading = false;
  late Stream getUsrData;
  String? _email = GlobalData.email,
      _fullName = GlobalData.displayName,
      _nickName = GlobalData.nickName,
      _avt = GlobalData.avatar,
      _phone = GlobalData.phone,
      _about = GlobalData.about;
  Gender? _gender = GlobalData.gender;
  late FocusNode focusNode;
  late FocusNode aboutFocusNode;
  bool _changeGender = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    aboutFocusNode = FocusNode();
    getUsrData = FirebaseFirestore.instance
        .collection('Users')
        .doc(GlobalData.email)
        .snapshots();

    ;

    // listen to focus changes
    focusNode.addListener(() => _phoneFocus = !_phoneFocus);
    aboutFocusNode.addListener(() => _aboutFocus = !_aboutFocus);
  }

  bool _phoneFocus = false;
  bool _aboutFocus = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getUsrData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data!;
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Your Profile',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Unsaved Changes",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
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
                              })
                          .then((value) =>
                              _isClosed ? Navigator.pop(context) : null);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: AppColors.violet,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        if (_checkValue(_fullName!, _gender!)) {
                          try {
                            print('avt: $_avt');
                            await updateUserData(_fullName, _nickName, _email,
                                _avt, _gender, _phone, _about);
                            // ignore: use_build_context_synchronously
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DialogCustom(
                                      'Your informaton is saved!', '');
                                });
                            await getUserData(_email, _avt);
                            Navigator.pop(context);
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
                                    "Your information is empty", '');
                              });
                        }
                      },
                      child: Text('Save',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: AppColors.violet,
                                  )),
                    ),
                  ]),
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          scaleH(180, context)),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: scaleW(20, context)),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: SizedBox(
                              height: scaleH(112, context),
                              width: scaleW(112, context),
                              child: Stack(children: [
                                _isUploading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : CircleAvatar(
                                        radius: scaleH(56, context),
                                        foregroundImage: _avt == null
                                            ? const AssetImage(
                                                    'assets/imgs/profileImgs/photo.png')
                                                as ImageProvider
                                            : NetworkImage(_avt!),
                                      ),
                                Positioned(
                                  right: 1,
                                  child: InkWell(
                                    // onTap: () async {
                                    //   await _getFromGallery();
                                    // },
                                    onTap: () => showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Wrap(
                                          children: [
                                            buildModal(Icons.camera,
                                                'Take a photo', 'camera'),
                                            buildModal(Icons.photo,
                                                'Choose a photo', 'gallery')
                                          ],
                                        );
                                      },
                                    ),
                                    child: Container(
                                      height: scaleH(29, context),
                                      width: scaleW(29, context),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            29,
                                          ),
                                        ),
                                        gradient: const LinearGradient(
                                          colors: <Color>[
                                            Color(0xff4596EA),
                                            Color(0xff4552CB),
                                          ],
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xff4552CB)
                                                .withOpacity(0.23),
                                            spreadRadius: 5,
                                            blurRadius: 17,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.add,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                          TextFormFieldCustom(
                            'Full Name',
                            data['name'],
                            true,
                            false,
                            true,
                            onChanged: (String value) => setState(() {
                              _fullName = value;
                            }),
                            onTap: () {},
                          ),
                          TextFormFieldCustom(
                            'Nick Name',
                            _nickName!,
                            false,
                            false,
                            false,
                            onChanged: (String value) => setState(() {
                              _nickName = value;
                            }),
                            onTap: () {},
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Owner',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: AppColors.gray,
                                      )),
                              SizedBox(
                                height: scaleH(10, context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  genderWidget(
                                    label: 'Male',
                                    icon: Icons.male,
                                    isSelected:
                                        _gender == Gender.male ? true : false,
                                    onPressed: () {
                                      setState(() {
                                        _gender = Gender.male;
                                        //_changeGender = true;
                                      });
                                    },
                                  ),
                                  genderWidget(
                                    label: 'Female',
                                    icon: Icons.female,
                                    isSelected:
                                        _gender == Gender.female ? true : false,
                                    onPressed: () {
                                      setState(() {
                                        _gender = Gender.female;
                                        //_changeGender = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextFormFieldCustom(
                            'Email',
                            data['email'],
                            false,
                            true,
                            false,
                            onChanged: () {},
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ChangeEmailDialog();
                                  });
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phone',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: _phoneFocus
                                            ? AppColors.violet
                                            : AppColors.gray,
                                      )),
                              IntlPhoneField(
                                disableLengthCheck: true,
                                initialValue: _phone,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                    prefixText: '|  ',
                                    prefixStyle: TextStyle(
                                        color: AppColors.gray,
                                        height: 1,
                                        fontSize: scaleH(22, context))),
                                showDropdownIcon: false,
                                dropdownTextStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: AppColors.violet,
                                    ),
                                showCountryFlag: false,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: AppColors.violet,
                                    ),
                                initialCountryCode: 'VN',
                                onChanged: (phone) {
                                  setState(() {
                                    _phone = phone.number;
                                  });
                                  print(phone.number);
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About me',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: _aboutFocus
                                            ? AppColors.violet
                                            : AppColors.gray,
                                      )),
                              SizedBox(
                                height: scaleH(10, context),
                              ),
                              TextFormField(
                                initialValue: _about,
                                maxLines: 3,
                                onChanged: (value) => setState(() {
                                  _about = value;
                                }),
                                focusNode: aboutFocusNode,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xfff8f7fb),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: Color(0xFFE4E3F3), width: 1)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
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
            .child('UserAvatar')
            .child(pickedFile.name);

        final UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));

        await uploadTask.whenComplete(() => setState(() {
              _isUploading = false;
            }));
        final temp = await storageRef.getDownloadURL();
        setState(() {
          _avt = temp;
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

  bool _checkValue(String name, Gender gd) {
    if (name == '' || gd == Gender.other) {
      return false;
    }
    return true;
  }
}
