import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/sign_up.dart';
import 'package:petcare_search/users/user_data.dart';
import '../utils/widget_utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  late UserCredential userCredential;
  late User? user;
  bool isEmailCorrect = false;

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future pwreset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text == ""
              ? "fake@email.com"
              : _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text('Please check your email.'));
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.message.toString()));
          });
    }
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
                height: scaleH(338, context),
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1,
                        colors: [Color(0xFF4596EA), Color(0xFF4552CB)])),
                child: Align(
                  alignment: const Alignment(-0.5, -0.3),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: scaleH(34, context)),
                  ),
                ),
              ),
              Positioned(
                top: scaleH(49, context),
                left: scaleW(14, context),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 32,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteGenerator.signin);
                  },
                ),
              ),
              Positioned(
                  top: scaleH(220, context),
                  left: scaleW(20, context),
                  child: Container(
                      height: scaleH(200, context),
                      width: scaleW(335, context),
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
                                  color: _emailFocus.hasFocus
                                      ? Colors.grey.shade100
                                      : Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 20, 15, 20),
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
                                        hintText:
                                            "Input email for password recovery",
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
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFF4552CB)))),
                                  ),
                                ),
                              )),
                          Flexible(
                            child: Center(
                              child: SizedBox(
                                height: scaleH(46, context),
                                width: scaleW(295, context),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      pwreset();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF4552CB),
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: scaleH(20, context)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25))),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ))),
              Positioned(
                top: scaleH(502, context),
                left: scaleW(20, context),
                right: scaleH(20, context),
                child: Row(
                  children: [
                    Container(
                        height: 1,
                        width: scaleW(92, context),
                        color: Colors.grey.shade200),
                    SizedBox(
                      width: scaleW(16, context),
                    ),
                    Text(
                      'or continue with',
                      style: TextStyle(
                          fontSize: scaleH(17, context),
                          letterSpacing: 0.16,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: scaleW(16, context),
                    ),
                    Container(
                        height: 1,
                        width: scaleW(92, context),
                        color: Colors.grey.shade200)
                  ],
                ),
              ),
              Positioned(
                  top: scaleH(537, context),
                  left: scaleW(104, context),
                  child: IconButton(
                      iconSize: scaleH(56, context),
                      onPressed: () async {
                        try {
                          final authProvider =
                              Provider.of<LogProvider>(context, listen: false);
                          userCredential =
                              await authProvider.loggingInWithFaceBook();
                          user = userCredential.user;
                          await addUser(user?.uid, user?.displayName,
                              user?.email, user?.photoURL);
                          await getUserData();
                          if (context.mounted) {
                            Navigator.pushNamed(context, RouteGenerator.home);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      icon: Container(
                        height: scaleH(56, context),
                        decoration: const BoxDecoration(
                            color: Color(0xFF3D5C98), shape: BoxShape.circle),
                        child: const Image(
                          image: AssetImage('assets/icons/fb.png'),
                        ),
                      ))),
              Positioned(
                  top: scaleH(537, context),
                  right: scaleW(104, context),
                  child: IconButton(
                      iconSize: scaleH(56, context),
                      onPressed: () async {
                        try {
                          final authProvider =
                              Provider.of<LogProvider>(context, listen: false);
                          userCredential =
                              await authProvider.loggingInWithGoogle();
                          user = userCredential.user;
                          await addUser(user?.uid, user?.displayName,
                              user?.email, user?.photoURL);
                          await getUserData();
                          if (context.mounted) {
                            Navigator.pushNamed(context, RouteGenerator.home);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      icon: Container(
                        height: scaleH(56, context),
                        decoration: const BoxDecoration(
                            color: Color(0xFFEF403B), shape: BoxShape.circle),
                        child: const Image(
                          image: AssetImage('assets/icons/google.png'),
                        ),
                      ))),
              Positioned(
                  bottom: scaleH(90, context),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Do not have an account yet?',
                            style: TextStyle(
                                fontSize: scaleH(16, context),
                                letterSpacing: 0.16),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: const Color(0xFF4552CB),
                                  fontSize: scaleH(16, context),
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
