// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/customizedWidgets/bottomlistof%20three/educationbottomlist.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';
import 'package:resume_maker/customizedWidgets/datepicker/date_picker.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';

final educount = ValueNotifier<int>(0);

class EducationalDetails extends StatefulWidget {
  const EducationalDetails({super.key});

  @override
  State<EducationalDetails> createState() => _EducationalDetailsState();
}

class _EducationalDetailsState extends State<EducationalDetails> {
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController coursedetailsController = TextEditingController();
  TextEditingController markcontroller = TextEditingController();
  DateTime? startdate;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool containershow = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: Form(
            key: formkey,
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.topLeft,
              width: 350,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeadingTextstyle(
                        content: ' Educational Details',
                        fontsize: 30,
                      ),

                      SizedBox(
                        height: screenHeight * .02,
                      ),
                      // const HeadingTextstyle(
                      //   content: 'Add Your Educational Qualification',
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
                            content: 'Add School / College',
                            fontsize: 20,
                          ),
                        ],
                      ),
                      containershow
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomTextfield(
                                  controller: schoolNameController,
                                  screenWidth: screenWidth,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter School Name';
                                    }
                                    return null;
                                  },
                                  hinttext: 'Name of School / College',
                                  textfieldmaxlength: 40,
                                  keyboardType: TextInputType.name,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const HeadingTextstyle(
                                      content: 'Graduated On',
                                      fontsize: 15,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: screenWidth * .15,
                                    ),
                                    DatePicker(
                                      onDateSelected: (DateTime selectedDate) {
                                        if (selectedDate
                                            .isBefore(DateTime.now())) {
                                          setState(() {
                                            startdate = selectedDate;
                                          });
                                        }
                                      },
                                    ),
                                    // DatePicker(
                                    //   onDateSelected: (DateTime selectedDate) {
                                    //     setState(() {
                                    //       startdate = selectedDate;
                                    //     });
                                    //   },
                                    // ),
                                  ],
                                ),
                                CustomTextfield(
                                  controller: coursedetailsController,
                                  hinttext: 'Course Details',
                                  screenWidth: screenWidth,
                                  textfieldmaxlength: 50,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter course details';
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * .18 < 120
                                          ? 120
                                          : screenWidth * .18,
                                      child: const HeadingTextstyle(
                                          content: 'Mark /Percentage',
                                          fontsize: 15,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(width: screenWidth * .1),
                                    CustomTextfield(
                                        controller: markcontroller,
                                        validator: (value) => null,
                                        screenWidth: screenWidth,
                                        customwidth: 150,
                                        hinttext: 'Mark or %',
                                        keyboardType: TextInputType.phone)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * .2,
                                    ),
                                    SizedBox(
                                      width: screenWidth * .1,
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
                                              addToEducation();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text('Added succesfully'),
                                                  duration: Duration(
                                                      milliseconds: 600),
                                                  backgroundColor:
                                                      Color.fromARGB(
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
                                              MainAxisAlignment.end,
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
                          : currentRessume?.education == null ||
                                  currentRessume!.education.isEmpty
                              ? SizedBox(
                                  height: screenHeight * .2,
                                  child: const Center(
                                    child: Text(
                                      'No Data Available',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                  ),
                                )
                              : Container(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  height: 500,
                                  child: ListView(
                                    children: [
                                      CustomListViewEducation(
                                        coursedetailsController:
                                            coursedetailsController,
                                        markcontroller: markcontroller,
                                        schoolNameController:
                                            schoolNameController,
                                        startdate: startdate,
                                        list: currentRessume?.education ?? [],
                                      )
                                    ],
                                  )),
                    ]),
              ),
            ),
          )),
    );
  }

  addToEducation() {
    currentRessume?.education.add({
      0: schoolNameController.text,
      1: startdate == null
          ? DateTime.now().toString()
          : DateFormat('dd-MM-yyyy').format(startdate!),
      2: coursedetailsController.text,
      3: markcontroller.text,
    });
    schoolNameController.clear();
    coursedetailsController.clear();
    markcontroller.clear();
    containershow = false;
    print(currentRessume?.education);
  }
}
