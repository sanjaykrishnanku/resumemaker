// ignore_for_file: avoid_print, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resume_maker/DataBAseOperations/uservalidationAndDelete/validation_user.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/MainPages/SignupOrSignin/signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showpassword = true;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  @override
  void dispose() {
    Hive.close();
    print('hive Disposed ');
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
          child: Column(children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              "Welcome OnBoard !",
              style: TextStyle(
                color: fourthcolor,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Elevate Your Career Journey",
                style: TextStyle(
                  color: secondarycolor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "with SmartCVBuilder",
                style: TextStyle(
                  color: secondarycolor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SingleChildScrollView(
                  child: SizedBox(
                    height: 100,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
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
                        fillColor: const Color.fromARGB(255, 209, 209, 209),
                        filled: true,
                        hintText: 'Enter your Username',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 148, 148, 148)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
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
                          fillColor: const Color.fromARGB(255, 209, 209, 209),
                          filled: true,
                          hintText: 'Enter your password',
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: screenWidth - (screenWidth * 20 / 100),
                    child: TextFormField(
                      controller: confirmpasswordcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter the Password';
                        }
                        if (passwordcontroller.text !=
                            confirmpasswordcontroller.text) {
                          return 'The password is incorrect ';
                        }
                        return null;
                      },
                      maxLength: 16,
                      obscureText: showpassword,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 209, 209, 209),
                          filled: true,
                          hintText: 'Confirm your password',
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
                          if (validationuser == true) {
                            fetchcurrentuser();
                            Navigator.pushReplacementNamed(context, 'welcomepage');
                  
                            print('inside the validationsuccess');
                          }
                          if (validationuser != true) {
                            print('inside the validation not success');
                            String newuserid = generateUniqueUserId();
                            saveUserAccount(usernamecontroller.text,
                                passwordcontroller.text, newuserid);
                            Navigator.pushReplacementNamed(context, 'welcomepage');
                            print('account added in hive ');
                          }
                        }
                      },
                      child: const Text(
                        'Sign Up',
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
                    'Already Have An Account',
                    style: TextStyle(
                      color: Color.fromARGB(146, 63, 63, 63),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 170, 120),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}


