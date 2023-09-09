import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/users/user_data.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/errordialog.dart';

class ChangeEmailDialog extends StatefulWidget {
  const ChangeEmailDialog({super.key});

  @override
  State<ChangeEmailDialog> createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends State<ChangeEmailDialog> {
  String _newEmail = '';
  String _password = '';
  Color _emailcheckColor = AppColors.gray;
  bool _hidePw = true;
  final FocusNode _passwordFocus = FocusNode();

  bool passwordObscure = true;
  @override
  void dispose() {
    _passwordFocus.dispose();
    super.dispose();
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: scaleH(300, context),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Change email',
                style: Theme.of(context).textTheme.headline2,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _newEmail = value;
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
                    size: scaleW(18, context),
                    Icons.check_circle_rounded,
                    color: _emailcheckColor,
                  ),
                  labelText: 'New email',
                  labelStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.gray,
                      ),
                  floatingLabelStyle:
                      Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppColors.violet,
                          ),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: passwordObscure,
                focusNode: _passwordFocus,
                onTap: () {
                  _requestFocus(_passwordFocus);
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      constraints: const BoxConstraints(),
                      iconSize: scaleW(18, context),
                      onPressed: () {
                        setState(() {
                          passwordObscure = !passwordObscure;
                        });
                      },
                      icon: passwordObscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                  labelText: 'Your password',
                  labelStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        color: AppColors.gray,
                      ),
                  floatingLabelStyle:
                      Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppColors.violet,
                          ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: scaleW(110, context),
                    height: scaleH(45, context),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: AppColors.violet, width: 1),
                                borderRadius: BorderRadius.circular(
                                    scaleW(15, context)))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: AppColors.violet, fontSize: 18.0),
                        )),
                  ),
                  Container(
                    width: scaleW(110, context),
                    height: scaleH(45, context),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.violet,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    scaleW(15, context)))),
                        onPressed: () => Navigator.of(context).pop(),
//                         onPressed: () async {
//                           try {
//                             final currentUsr =
//                                 await FirebaseAuth.instance.currentUser;
//                             AuthCredential credential =
//                                 EmailAuthProvider.credential(
//                                     email: GlobalData.email!,
//                                     password: _password);
//                             print(currentUsr!.uid);
// // Reauthenticate
//                             await FirebaseAuth.instance.currentUser!
//                                 .reauthenticateWithCredential(credential)
//                                 .then((value) async {
//                               await currentUsr.updateEmail(_newEmail);
//                               await FirebaseFirestore.instance
//                                   .collection('Users')
//                                   .doc(_newEmail)
//                                   .set({
//                                 'email': _newEmail,
//                                 'avatar': GlobalData.avatar,
//                                 'name': GlobalData.displayName,
//                               });
//                               await getUserData(_newEmail, GlobalData.avatar);

//                               // await FirebaseFirestore.instance
//                               //     .collection('Users')
//                               //     .doc(GlobalData.email)
//                               //     .delete();
//                               print('done');

//                               Navigator.of(context).pop();
//                             });
//                           } catch (e) {
//                             // ignore: use_build_context_synchronously
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return ErrorDialog(e.toString());
//                                 });
//                           }
//                         },
                        child: Text(
                          'Change',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
