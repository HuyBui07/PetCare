import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/bottomButton.dart';
import 'package:petcare_search/widgets/genderWidget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  late FocusNode focusNode;
  File? imageFile;

  void initState() {
    focusNode = FocusNode();

    // listen to focus changes
    focusNode.addListener(() => _phoneFocus = !_phoneFocus);
  }

  Color _namecheckColor = AppColors.gray;
  Color _emailcheckColor = AppColors.gray;
  String _selectedGender = 'Male';
  bool _phoneFocus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Your Profile',
            style: Theme.of(context).textTheme.headline3,
          ),
          centerTitle: true,
          leading: Icon(
            Icons.arrow_back,
            color: AppColors.violet,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Skip',
                  style: Theme.of(context).textTheme.headline6?.apply(
                        color: AppColors.violet,
                      )),
            ),
          ]),
      body: SingleChildScrollView(
        //physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              //minWidth: MediaQuery.of(context).size.width,
              minHeight:
                  MediaQuery.of(context).size.height - scaleH(180, context)),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scaleW(20, context)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Container(
                      height: scaleH(112, context),
                      width: scaleW(112, context),
                      child: Stack(children: [
                        CircleAvatar(
                          radius: scaleH(56, context),
                          backgroundImage: imageFile == null
                              ? AssetImage('assets/imgs/profileImgs/photo.png')
                              : FileImage(
                                  imageFile!,
                                  //fit: BoxFit.cover,
                                ) as ImageProvider,
                          //AssetImage('assets/profileImgs/photo.png'),
                        ),
                        Positioned(
                          right: 1,
                          child: InkWell(
                            onTap: () {
                              _getFromGallery();
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
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
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
                      labelStyle: Theme.of(context).textTheme.headline6!.apply(
                            color: AppColors.gray,
                          ),
                      floatingLabelStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .apply(color: AppColors.violet, fontSizeFactor: 1.3),
                    ),
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Owner',
                          style: Theme.of(context).textTheme.headline6!.apply(
                                color: AppColors.gray,
                              )),
                      SizedBox(
                        height: scaleH(10, context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          genderWidget(
                            gender: 'Male',
                            onPressed: () {
                              setState(() {
                                _selectedGender = 'Male';
                              });
                            },
                            selected: _selectedGender,
                          ),
                          genderWidget(
                            gender: 'Female',
                            onPressed: () {
                              setState(() {
                                _selectedGender = 'Female';
                              });
                            },
                            selected: _selectedGender,
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                    onChanged: (value) {
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
                      labelStyle: Theme.of(context).textTheme.headline6!.apply(
                            color: AppColors.gray,
                          ),
                      floatingLabelStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .apply(color: AppColors.violet, fontSizeFactor: 1.3),
                    ),
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    // validator: (String? value) {
                    //   return (value != null && value.contains('@'))
                    //       ? 'Do not use the @ char.'
                    //       : null;
                    // },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone',
                          style: Theme.of(context).textTheme.headline6!.apply(
                                color: _phoneFocus
                                    ? AppColors.violet
                                    : AppColors.gray,
                              )),
                      IntlPhoneField(
                        focusNode: focusNode,
                        decoration: InputDecoration(
                            prefixText: '|  ',
                            prefixStyle: TextStyle(
                                color: AppColors.gray,
                                height: 1,
                                fontSize: scaleH(22, context))),
                        showDropdownIcon: false,
                        dropdownTextStyle:
                            Theme.of(context).textTheme.headline4!.apply(
                                  color: AppColors.violet,
                                ),
                        showCountryFlag: false,
                        style: Theme.of(context).textTheme.headline4!.apply(
                              color: AppColors.violet,
                            ),
                        initialCountryCode: 'VN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About me',
                          style: Theme.of(context).textTheme.headline6!.apply(
                                color: AppColors.gray,
                              )),
                      SizedBox(
                        height: scaleH(10, context),
                      ),
                      // Container(
                      //   height: scaleH(76, context),
                      //   decoration: BoxDecoration(
                      //       color: const Color(0xfff8f7fb),
                      //       borderRadius: BorderRadius.circular(scaleW(8, context)),
                      //       border:
                      //           Border.all(width: 1, color: const Color(0xFFE4E3F3))),

                      // ),
                      const TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff8f7fb),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFE4E3F3), width: 1)),
                        ),
                      )
                    ],
                  ),
                  BottomButtom('Get Started')
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: scaleH(83, context),
        color: Colors.amber,
        // child: Icon(Icons.home),
      ),
    );
  }

  _getFromGallery() async {
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
    }
  }
}
