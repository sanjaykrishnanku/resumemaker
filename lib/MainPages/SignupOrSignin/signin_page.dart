// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resume_maker/DataBAseOperations/uservalidationAndDelete/validation_user.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/MainPages/SignupOrSignin/signup_page.dart';

bool validationuser = false;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientcolors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight - (screenHeight * 70 / 100),
              ),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  color: fourthcolor,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Elevate Your Career Journey ",
                  style: TextStyle(
                    color: primarycolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "with SMART CV BUILDER!",
                  style: TextStyle(
                    color: primarycolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: SizedBox(
                        width: screenWidth - (screenWidth * 20 / 100),
                        child: TextFormField(
                          controller: usernamecontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the username';
                            }
                            if (value.length < 5) {
                              return 'Text must be at least 5 characters long';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 214, 214, 214),
                            filled: true,
                            hintText: 'Enter your Username',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 148, 148, 148)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: SizedBox(
                        width: screenWidth - (screenWidth * 20 / 100),
                        child: TextFormField(
                          controller: passwordcontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the Password';
                            }
                            if (value.length < 8) {
                              return 'password  must be at least 8 characters long';
                            }
                            return null;
                          },
                          maxLength: 16,
                          obscureText: showpassword,
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 102, 102, 102)),
                              fillColor:
                                  const Color.fromARGB(255, 211, 211, 211),
                              filled: true,
                              hintText: 'Enter your password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              suffixIcon: IconButton(
                                icon: showpassword
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.blue,
                                      ),
                                onPressed: () {
                                  if (showpassword) {
                                    showpassword = false;
                                  } else {
                                    showpassword = true;
                                  }
                                  setState(() {});
                                },
                              )),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            backgroundColor: fourthcolor,
                            // shape:const CircleBorder()    ,
                          ),
                          onPressed: () async {
                            validationuser = await validation(
                                usernamecontroller.value.text,
                                passwordcontroller.value.text);
                            if (_formKey.currentState!.validate()) {
                              if (validationuser) {
                                fetchcurrentuser();
                                Navigator.pushReplacementNamed(context, 'welcomepage');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Incorrect username or password'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Does\'nt Have An Account',
                      style: TextStyle(
                        color: Color.fromARGB(255, 109, 109, 109),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 86, 192, 136),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
