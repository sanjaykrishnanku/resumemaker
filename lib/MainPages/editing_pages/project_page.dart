// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/customizedWidgets/bottomlistof%20three/projectbottomlist.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';
import 'package:resume_maker/customizedWidgets/datepicker/date_picker.dart';
import 'package:resume_maker/customizedWidgets/dropdownlist/dropdownlist.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool containershow = false;
  TextEditingController projectnamecontroller = TextEditingController();
  TextEditingController projectdetailscontroller = TextEditingController();
  TextEditingController rolecontroller = TextEditingController();
  DateTime? startdate;
  DateTime? enddate;
  String? teamsize;
  List<String> numbersList =
      List<String>.generate(101, (index) => index.toString());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.only(top: 30),
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Form(
            key: formkey,
            child: Container(
              alignment: Alignment.topLeft,
              width: 350,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingTextstyle(
                      content: ' Project Details',
                      fontsize: 30,
                    ),

                    SizedBox(
                      height: screenHeight * .01,
                    ),
                    // const HeadingTextstyle(
                    //   content: 'Add Your Project Details',
                    //   fontsize: 15,
                    // ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        containershow
                            ? TextButton(
                                child: const Icon(
                                  Icons.do_disturb_on_rounded,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(2, 2))
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    containershow = false;
                                  });
                                },
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(2, 2))
                                  ],
                                  size: 25,
                                ),
                                onPressed: () {
                                  setState(() {
                                    containershow = true;
                                  });
                                },
                              ),
                        const HeadingTextstyle(
                          content: 'Add project',
                          fontsize: 35,
                        ),
                      ],
                    ),
                    containershow
                        ? Column(
                            children: [
                              CustomTextfield(
                                controller: projectnamecontroller,
                                screenWidth: screenWidth,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter Project Name';
                                  }
                                  return null;
                                },
                                hinttext: 'Project Name ',
                                textfieldmaxlength: 50,
                                keyboardType: TextInputType.name,
                              ),
                              CustomTextfield(
                                controller: projectdetailscontroller,
                                hinttext: 'Project Details',
                                screenWidth: screenWidth,
                                maxlines: 4,
                                textfieldmaxlength: 200,
                                keyboardType: TextInputType.multiline,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter Project Details';
                                  }
                                  return null;
                                },
                              ),
                              CustomTextfield(
                                controller: rolecontroller,
                                screenWidth: screenWidth,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please add your Role';
                                  }
                                  return null;
                                },
                                hinttext: 'YourRole',
                                textfieldmaxlength: 20,
                                keyboardType: TextInputType.name,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const HeadingTextstyle(
                                    fontsize: 20,
                                    content: 'Start Date',
                                  ),
                                  DatePicker(
                                    onDateSelected: (DateTime selectedDate) {
                                      setState(() {
                                        startdate = selectedDate;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const HeadingTextstyle(
                                        content: 'End Date', fontsize: 20),
                                    DatePicker(
                                      onDateSelected: (DateTime selectedDate) {
                                        setState(() {
                                          enddate = selectedDate;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const HeadingTextstyle(
                                          content: 'Team Size', fontsize: 20),
                                      SizedBox(
                                        width: screenWidth * .1,
                                      ),
                                      CustomDropDownList(
                                        items: numbersList,
                                        onChanged: (value) {
                                          setState(() {
                                            teamsize = value;
                                          });
                                        },
                                        selectedValue: teamsize ?? '0',
                                      )
                                    ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: screenWidth * .1,
                                    height: 100,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: fourthcolor,
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (formkey.currentState!
                                              .validate()) {
                                            // currentRessume?.projects.clear();
                                            currentRessume?.projects.add({
                                              0: projectnamecontroller.text,
                                              1: projectdetailscontroller.text,
                                              2: startdate == null
                                                  ? ' '
                                                  : DateFormat('dd-MM-yyyy')
                                                      .format(startdate!),
                                              3: enddate == null
                                                  ? ' '
                                                  : DateFormat('dd-MM-yyyy')
                                                      .format(enddate!),
                                              4: rolecontroller.text,
                                              5: teamsize ?? '0'
                                            });
                                            print(currentRessume?.projects);
                                            projectnamecontroller.clear();
                                            projectdetailscontroller.clear();
                                            containershow = false;

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Added succesfully'),
                                                duration:
                                                    Duration(milliseconds: 600),
                                                backgroundColor: Color.fromARGB(
                                                    255, 158, 158, 158),
                                                width: 200,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                            
                                          }
                                        });
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 12.0, right: 12),
                                            child: Text('Add',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize: 20)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * .2,
                              )
                            ],
                          )
                        : currentRessume?.projects == null
                            ? SizedBox(
                                height: screenHeight * .2,
                                child: const Center(
                                  child: Text(
                                    'No Data Available',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20),
                                  ),
                                ),
                              )
                            : Container(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                height: 600,
                                child: ListView(
                                  children: [
                                    CustomListViewProjects(
                                      enddate: enddate,
                                      list: currentRessume?.projects ?? [],
                                      projectDetailsController:
                                          projectdetailscontroller,
                                      projectNameController:
                                          projectnamecontroller,
                                      rolecontroller: rolecontroller,
                                      startdate: startdate,
                                      teamsize: teamsize,
                                    )
                                  ],
                                )),
                  ]),
            ),
          )),
    );
  }
}
