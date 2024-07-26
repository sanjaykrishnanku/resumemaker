import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/MainPages/editing_pages/educational_details.dart';
import 'package:resume_maker/MainPages/editing_pages/experiance_page.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/MainPages/editing_pages/personal_details.dart';
import 'package:resume_maker/MainPages/editing_pages/profile_page.dart';
import 'package:resume_maker/MainPages/editing_pages/project_page.dart';
import 'package:resume_maker/MainPages/editing_pages/skills_page.dart';
import 'package:resume_maker/MainPages/previewpage/previewpage.dart';

List<Widget> editingpages = [
  const PersonalDetails(),
  const EducationalDetails(),
  const ExperiancePage(),
  const ProjectPage(),
  const SkillsAndOthersPage(),
  const ProfileImagePage()
];
PageController pagecontroller = PageController();

class EditingPage extends StatefulWidget {
  const EditingPage({
    super.key,
  });

  @override
  State<EditingPage> createState() => _EditingPageState();
}

int currentindex = 0;

class _EditingPageState extends State<EditingPage> {
  @override
  void initState() {
    super.initState();
    fetchResume();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              setState(() {
                currentindex = 0;
              });
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
            ),
          ),
          actions: [
            currentindex != 5
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        updateResume();
                        if (currentindex < 6 && currentindex >= 0) {
                          currentindex = currentindex + 1;

                          pagecontroller.jumpToPage(currentindex);
                        }
                      });
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      onPressed: () {
                        
                        updateResume();
                         Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const PreviewPage();
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return const  Resumeview();
                          },
                        ));
                        currentindex = 0;
                      },
                      icon: const Column(
                        children: [
                          Icon(
                            Icons.save,
                            size: 40,
                            color: Colors.white,
                          ),
                          // Text(
                          //   'Save',
                          //   style: TextStyle(
                          //       fontSize: 14, fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),
                          // ),
                        ],
                      ),
                      tooltip: 'Save',
                    ),
                  )
          ],
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 100),
              child: Container(
                decoration: BoxDecoration(color: fourthcolor),
                child: null,
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: PageView.builder(
            controller: pagecontroller,
            itemBuilder: (context, index) => editingpages[index],
            itemCount: editingpages.length,
            onPageChanged: (value) => setState(() {
              currentindex = value;
            }),
            pageSnapping: true,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(currentindex == 0
                          ? Icons.person_2_rounded
                          : Icons.person_outline_outlined),
                      label: 'Personal'),
                  BottomNavigationBarItem(
                      icon: Icon(currentindex == 1
                          ? Icons.school
                          : Icons.school_outlined),
                      label: 'Educational'),
                  BottomNavigationBarItem(
                      icon: Icon(currentindex == 2
                          ? Icons.engineering
                          : Icons.engineering_outlined),
                      label: 'Experiance'),
                  BottomNavigationBarItem(
                      icon: Icon(currentindex == 3
                          ? Icons.emoji_objects
                          : Icons.emoji_objects_outlined),
                      label: 'Projects'),
                  BottomNavigationBarItem(
                      icon: Icon(currentindex == 4
                          ? Icons.psychology
                          : Icons.psychology_outlined),
                      label: 'Skills & others'),
                  BottomNavigationBarItem(
                      icon: Icon(currentindex == 5
                          ? Icons.account_circle_rounded
                          : Icons.account_circle_outlined),
                      label: 'Profile image')
                ],
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                onTap: (value) => setState(() {
                  if (currentindex - value > 1 || value - currentindex > 1) {
                    pagecontroller.jumpToPage(value);
                    // animateToPage(value,
                    //     duration: const Duration(milliseconds: 300),
                    //     curve: Curves.easeIn);
                  }
                  // else{pagecontroller.jumpToPage(value);}
                  else {
                    pagecontroller.animateToPage(
                      value,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                  currentindex = value;
                }),
                currentIndex: currentindex,
                backgroundColor: fourthcolor,
                enableFeedback: true,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                showUnselectedLabels: false,
                selectedIconTheme: const IconThemeData(size: 20),
                unselectedIconTheme: const IconThemeData(size: 30),
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: false,
        extendBody: true,
      ),
    );
  }
}
