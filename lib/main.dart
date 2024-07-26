import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:resume_maker/MainPages/foundationpages/welcome_page.dart';
import 'package:resume_maker/MainPages/SignupOrSignin/signin_page.dart';
import 'package:resume_maker/MainPages/SignupOrSignin/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

// Hive Typeadapters
  Hive.registerAdapter(UserAccountAdapter());
  Hive.registerAdapter(ResumeDataAdapter());
  Hive.registerAdapter(CustomUserDataAdapter());

  // Hiveboxes
  await Hive.openBox<UserAccount>('userAccountBox');
  await Hive.openBox<bool>('isloggedin');
  await Hive.openBox<CustomUserData>('customUserDataBox');
  await Hive.openBox<String>('currentuserid');
  await Hive.openBox<ResumeData>('ressumedata');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: 
      ThemeData(
        primaryColor: fourthcolor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: thirdcolor),
      ),
    darkTheme:ThemeData(
        primaryColor: fourthcolor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: thirdcolor),
      ) ,  
    themeMode:ThemeMode.system ,

      debugShowCheckedModeBanner: false,
      home: const FirstPage(),
      routes: {
        'signinpage': (context) => const SignInPage(),
        'signuppage': (context) => const SignUpPage(),
        'welcomepage': (context) => const WelcomePage(),
      },
    );
  }
}
