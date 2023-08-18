import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/bottomButton.dart';
import 'package:petcare_search/widgets/genderWidget.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  Color _namecheckColor = AppColors.gray;
  Color _emailcheckColor = AppColors.gray;
  String _selectedGender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: scaleW(20, context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                height: scaleH(112, context),
                width: scaleW(112, context),
                child: Stack(children: [
                  CircleAvatar(
                    radius: scaleH(56, context),
                    backgroundImage: AssetImage('assets/profileImgs/photo.png'),
                  ),
                  Positioned(
                    right: 1,
                    child: InkWell(
                      onTap: () {},
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
                              color: const Color(0xff4552CB).withOpacity(0.23),
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
                return (value != null) ? 'Please enter your full name!' : null;
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
                Text('About me',
                    style: Theme.of(context).textTheme.headline6!.apply(
                          color: AppColors.gray,
                        )),
                SizedBox(
                  height: scaleH(10, context),
                ),
                Container(
                  height: scaleH(76, context),
                  decoration: BoxDecoration(
                      color: const Color(0xfff8f7fb),
                      borderRadius: BorderRadius.circular(scaleW(8, context)),
                      border:
                          Border.all(width: 1, color: const Color(0xFFE4E3F3))),
                ),
              ],
            ),
            BottomButtom('Get Started')
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: scaleH(83, context),
        color: Colors.amber,
        // child: Icon(Icons.home),
      ),
    );
  }
}
