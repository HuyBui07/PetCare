import 'package:flutter/material.dart';
import 'package:petcare_search/routes/routes.dart';
import '../utils/widget_utils.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  bool isEmailCorrect = false;

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
                  top: scaleH(171, context),
                  left: scaleW(20, context),
                  child: Container(
                      height: scaleH(290, context),
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
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
