import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:petcare_search/screens/mainSearch.dart';
import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/users/user_data.dart';
import 'registration.dart';
import '../services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  late final UserCredential userCredential;
  late final User? user;
  bool isNameCorrect = false;
  RegExp rexName =
      RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  bool isEmailCorrect = false;
  bool passwordObscure = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  double scaleH(original) {
    return (original * MediaQuery.of(context).size.height / 812);
  }

  double scaleW(original) {
    return (original * MediaQuery.of(context).size.width / 375);
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: scaleH(338),
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1,
                        colors: [Color(0xFF4596EA), Color(0xFF4552CB)])),
                child: Align(
                  alignment: const Alignment(-0.7, -0.3),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: scaleH(34)),
                  ),
                ),
              ),
              Positioned(
                top: scaleH(49),
                left: scaleW(14),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 32,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Registration()));
                  },
                ),
              ),
              Positioned(
                  top: scaleH(171),
                  left: scaleW(20),
                  child: Container(
                    height: scaleH(406),
                    width: scaleW(335),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _nameFocus.hasFocus
                                    ? Colors.grey.shade100
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 7, 15, 12),
                                child: TextFormField(
                                  controller: _nameController,
                                  onChanged: (val) {
                                    setState(() {
                                      isNameCorrect = rexName.hasMatch(val);
                                    });
                                  },
                                  focusNode: _nameFocus,
                                  onTap: () {
                                    _requestFocus(_nameFocus);
                                  },
                                  decoration: InputDecoration(
                                      suffix: isNameCorrect
                                          ? const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 10, 0),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/icons/success.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : null,
                                      labelText: 'Full name',
                                      labelStyle: TextStyle(
                                          color: _emailFocus.hasFocus
                                              ? const Color(0xFF4552CB)
                                              : Colors.grey.shade300,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Color(0xFF4552CB)))),
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _emailFocus.hasFocus
                                    ? Colors.grey.shade100
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 7, 15, 12),
                                child: TextFormField(
                                  controller: _emailController,
                                  onChanged: (val) {
                                    setState(() {
                                      isEmailCorrect =
                                          EmailValidator.validate(val);
                                    });
                                  },
                                  focusNode: _emailFocus,
                                  onTap: () {
                                    _requestFocus(_emailFocus);
                                  },
                                  decoration: InputDecoration(
                                      suffix: isEmailCorrect
                                          ? const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 10, 0),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/icons/success.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : null,
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                          color: _emailFocus.hasFocus
                                              ? const Color(0xFF4552CB)
                                              : Colors.grey.shade300,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Color(0xFF4552CB)))),
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _passwordFocus.hasFocus
                                    ? Colors.grey.shade100
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 7, 15, 12),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: passwordObscure,
                                  focusNode: _passwordFocus,
                                  onTap: () {
                                    _requestFocus(_passwordFocus);
                                  },
                                  decoration: InputDecoration(
                                      suffix: IconButton(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          constraints: const BoxConstraints(),
                                          iconSize: 15,
                                          onPressed: () {
                                            setState(() {
                                              passwordObscure =
                                                  !passwordObscure;
                                            });
                                          },
                                          icon: passwordObscure
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off)),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          color: _passwordFocus.hasFocus
                                              ? const Color(0xFF4552CB)
                                              : Colors.grey.shade300,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Color(0xFF4552CB)))),
                                ),
                              ),
                            )),
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: scaleH(46),
                                  width: scaleW(295),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          userCredential = await FirebaseAuth
                                              .instance
                                              .createUserWithEmailAndPassword(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text);

                                          user = userCredential.user;
                                          await addUser(_nameController.text,
                                              user?.email, user?.photoURL);
                                          await getUserData(
                                              user?.email, user?.photoURL);

                                          if (context.mounted) {
                                            Navigator.pushNamed(
                                                context, 'search');
                                          }
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF4552CB),
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: scaleH(20)),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ]),
                        )
                      ],
                    ),
                  )),
              Positioned(
                top: scaleH(606),
                left: scaleW(20),
                right: scaleH(20),
                child: Row(
                  children: [
                    Container(
                        height: 1,
                        width: scaleW(92),
                        color: Colors.grey.shade200),
                    SizedBox(
                      width: scaleW(16),
                    ),
                    Text(
                      'or continue with',
                      style: TextStyle(
                          fontSize: scaleH(17),
                          letterSpacing: 0.16,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: scaleW(16),
                    ),
                    Container(
                        height: 1,
                        width: scaleW(92),
                        color: Colors.grey.shade200)
                  ],
                ),
              ),
              Positioned(
                  top: scaleH(642),
                  left: scaleW(104),
                  child: IconButton(
                      iconSize: scaleH(56),
                      onPressed: () {},
                      icon: Container(
                        height: scaleH(56),
                        decoration: const BoxDecoration(
                            color: Color(0xFF3D5C98), shape: BoxShape.circle),
                        child: const Image(
                          image: AssetImage('assets/icons/fb.png'),
                        ),
                      ))),
              Positioned(
                  top: scaleH(642),
                  right: scaleW(104),
                  child: IconButton(
                      iconSize: scaleH(56),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF4552CB),
                                ),
                              );
                            });

                        googleLogIn().then((value) => Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => const SearchMain())));

                        Navigator.of(context).pop();
                      },
                      icon: Container(
                        height: scaleH(56),
                        decoration: const BoxDecoration(
                            color: Color(0xFFEF403B), shape: BoxShape.circle),
                        child: const Image(
                          image: AssetImage('assets/icons/google.png'),
                        ),
                      ))),
              Positioned(
                  bottom: scaleH(50),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontSize: scaleH(16), letterSpacing: 0.16),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: const Color(0xFF4552CB),
                                  fontSize: scaleH(16),
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
