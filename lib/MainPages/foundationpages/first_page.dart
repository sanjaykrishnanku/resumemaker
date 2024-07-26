import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/uservalidationAndDelete/validation_user.dart';
import 'package:resume_maker/MainPages/foundationpages/welcome_page.dart';
import 'package:resume_maker/MainPages/SignupOrSignin/signup_page.dart';

bool isloggedIn = false;

List<Color> gradientcolors = [whitebg, whitebg];
Color whitebg = const Color.fromARGB(255, 255, 255, 255);
Color darkThemeColor = const Color.fromARGB(255, 255, 255, 255);
Color primarycolor = const Color.fromRGBO(2, 103, 193, 1);
Color secondarycolor = const Color.fromRGBO(00, 117, 196, 1);
Color thirdcolor = const Color.fromRGBO(239, 160, 11, .5);
Color fourthcolor = const Color.fromARGB(255, 142, 84, 160);

Color black = Colors.black;
Color usedcoloryellow = const Color.fromRGBO(247, 231, 51, 1);

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: isloggedin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          if (snapshot.data == true) {
            fetchcurrentuser();
            return const WelcomePage();
          } else {
            return const SignUpPage();
          }
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const SignUpPage();
        }
      },
    );
  }
}
