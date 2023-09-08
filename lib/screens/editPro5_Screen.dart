import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/users/user_data.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/errordialog.dart';
import 'package:petcare_search/widgets/genderWidget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  bool _isUploading = false;
  late Stream getUsrData;
  String? _email = GlobalData.email,
      _fullName = GlobalData.displayName,
      _nickName = GlobalData.nickName,
      _avt = GlobalData.avatar,
      _gender = GlobalData.gender,
      _phone = GlobalData.phone,
      _about = GlobalData.about;
  late FocusNode focusNode;
  late FocusNode aboutFocusNode;
  bool _changeGender = false;
  File? imageFile;

  late var _data;
  void initState() {
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

  Color _namecheckColor = AppColors.green;
  Color _emailcheckColor = AppColors.green;
  bool _phoneFocus = false;
  bool _aboutFocus = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getUsrData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    color: AppColors.violet,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        try {
                          print('avt: $_avt');
                          await updateUserData(_fullName, _nickName, _email,
                              _avt, _gender, _phone, _about);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ErrorDialog('Your informaton is saved!');
                              });
                          await getUserData(_email, _avt);
                          Navigator.pop(context);
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ErrorDialog(e.toString());
                              });
                        }
                        ;
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
                                    ? Center(child: CircularProgressIndicator())
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
                                    onTap: () async {
                                      await _getFromGallery();
                                    },
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
                          TextFormField(
                            initialValue: data['name'],
                            onChanged: (value) {
                              setState(() {
                                _fullName = value;
                              });
                              value.isEmpty
                                  ? setState(() {
                                      _namecheckColor = AppColors.gray;
                                    })
                                  : setState(() {
                                      _namecheckColor = AppColors.green;
                                    });
                            },
                            validator: (String? value) {
                              return (value != null)
                                  ? 'Please enter your full name!'
                                  : null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.check_circle_rounded,
                                color: _namecheckColor,
                              ),
                              hintText: 'Enter your fullname',
                              labelText: 'Full Name',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColors.gray,
                                  ),
                              floatingLabelStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColors.violet,
                                  ),
                            ),
                          ),
                          TextFormField(
                            initialValue: _nickName,
                            onChanged: (value) {
                              setState(() {
                                _nickName = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your nickname',
                              labelText: 'Nick name',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColors.gray,
                                  ),
                              floatingLabelStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColors.violet,
                                  ),
                            ),
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
                                      gender: 'Male',
                                      onPressed: () {
                                        setState(() {
                                          _gender = 'Male';
                                          _changeGender = true;
                                        });
                                      },
                                      selected: !_changeGender &&
                                              data.data().containsKey('gender')
                                          ? data['gender']
                                          : _gender),
                                  genderWidget(
                                      gender: 'Female',
                                      onPressed: () {
                                        setState(() {
                                          _gender = 'Female';
                                          _changeGender = true;
                                        });
                                      },
                                      selected: !_changeGender &&
                                              data.data().containsKey('gender')
                                          ? data['gender']
                                          : _gender),
                                ],
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: data['email'],
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                              value.isNotEmpty && value.contains('@')
                                  ? setState(() {
                                      _emailcheckColor = AppColors.green;
                                    })
                                  : setState(() {
                                      _emailcheckColor = AppColors.gray;
                                    });
                            },
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.check_circle_rounded,
                                color: _emailcheckColor,
                              ),
                              hintText: 'Enter your email',
                              labelText: 'Email',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColors.gray,
                                  ),
                              floatingLabelStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColors.violet,
                                  ),
                            ),
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
                                  print(phone.completeNumber);
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

  _getFromGallery() async {
    try {
      setState(() {
        _isUploading = true;
      });
      final ImagePicker picker = ImagePicker();
// Pick an image.
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('UserAvatar')
            .child(pickedFile.name);

        final UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));
        TaskSnapshot storageSnapshot =
            await uploadTask.whenComplete(() => setState(() {
                  _isUploading = false;
                }));
        final temp = await storageRef.getDownloadURL();
        print(temp);
        setState(() {
          _avt = temp;
        });
        print('avatar2: $_avt');
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(e.toString());
          });
    }
  }
}
