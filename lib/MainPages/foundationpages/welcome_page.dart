import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:resume_maker/DataBAseOperations/uservalidationAndDelete/delete_account.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/DataBAseOperations/uservalidationAndDelete/validation_user.dart';
import 'package:resume_maker/MainPages/foundationpages/editing_page.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/customizedWidgets/custom%20containers/resumeshowbox.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController namecontroller = TextEditingController();
  Future<void> fetchData() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchresumes(fetchData);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) {
          return PopupMenuButton<String>(
            icon: const Icon(
              Icons.menu_outlined,
              size: 50,
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logOut',
                  child: TextButton(
                    child: const Text('Log Out'),
                    onPressed: () {
                      setState(() {
                        loggedout();
                        Navigator.popAndPushNamed(context, 'signinpage');
                      });
                    },
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'deleteAccount',
                  child: TextButton(
                    child: const Text('Delete Account'),
                    onPressed: () {
                      setState(() {
                        deleteUserAccount(currentUserId);
                        loggedout();
                        Navigator.popAndPushNamed(context, 'signinpage');
                      });
                    },
                  ),
                ),
              ];
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Container(
        color: Colors.white,
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: screenHeight * 0.2,
            ),
            Text(
              "Welcome Back!",
              style: TextStyle(
                color: black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            )
                .animate()
                .fade(begin: 0, delay: const Duration(milliseconds: 300)),
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
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: recentcontainer(screenWidth, screenHeight, fetchData),
            ),
            SizedBox(
              height: screenHeight * .1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                backgroundColor: fourthcolor,
                shadowColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Text(
                        'Create New Profile',
                        style: TextStyle(
                          color: fourthcolor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      content: CustomTextfield(
                        screenWidth: double.maxFinite - 20,
                        keyboardType: TextInputType.name,
                        controller: namecontroller,
                        validator: (value) => null,
                        hinttext: 'Name',
                        textfieldmaxlength: 20,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            selectionColor: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            addRessume(namecontroller.text);
                            fetchresumes(fetchData);
                            setState(() {});
                            currentRessume = null;
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditingPage(),
                                ));
                          },
                          child: const Text('Create'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Create New Cv',
                  style: TextStyle(
                    color: Colors.white,
                    //  Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }
}
