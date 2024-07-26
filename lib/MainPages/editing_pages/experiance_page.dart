// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/customizedWidgets/bottomlistof%20three/experiancebottomlist.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';
import 'package:resume_maker/customizedWidgets/datepicker/date_picker.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';

class ExperiancePage extends StatefulWidget {
  const ExperiancePage({super.key});

  @override
  State<ExperiancePage> createState() => _ExperiancePageState();
}

class _ExperiancePageState extends State<ExperiancePage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  DateTime? startdate;
  DateTime? enddate;
  bool containershow = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.only(top: 30),
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Container(
              alignment: Alignment.topLeft,
              width: 350,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingTextstyle(
                      content: ' Experiance Details',
                      fontsize: 30,
                    ),

                    SizedBox(
                      height: screenHeight * .01,
                    ),
                    // const HeadingTextstyle(
                    //   content: 'Add Experiance Details',
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
                          content: 'Add Company',
                          fontsize: 20,
                        ),
                      ],
                    ),
                    containershow
                        ? Column(
                            children: [
                              // const HeadingTextstyle(
                              //   content: 'Add Details',
                              //   fontsize: 20,
                              // ),
                              CustomTextfield(
                                controller: companyNameController,
                                screenWidth: screenWidth,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Company Name';
                                  }
                                  return null;
                                },
                                hinttext: 'Company Name ',
                                textfieldmaxlength: 40,
                                keyboardType: TextInputType.name,
                              ),

                              CustomTextfield(
                                controller: jobController,
                                hinttext: 'Job Role',
                                screenWidth: screenWidth,
                                textfieldmaxlength: 50,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Job Role';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Start Date',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: screenWidth * .1,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'End Date',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: screenWidth * .1,
                                    ),
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
                                padding: const EdgeInsets.only(top: 40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * .3,
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
                                              currentRessume?.experiance.add({
                                                0: companyNameController.text,
                                                1: jobController.text,
                                                2: startdate == null
                                                    ? ' '
                                                    : DateFormat('dd-MM-yyyy')
                                                        .format(startdate!),
                                                3: enddate == null
                                                    ? ' '
                                                    : DateFormat('dd-MM-yyyy')
                                                        .format(enddate!),
                                              });
                                              updateResume();
                                              print(currentRessume?.experiance);
                                              companyNameController.clear();
                                              jobController.clear();
                                              containershow = false;

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
                              ),
                              SizedBox(
                                height: screenHeight * .2,
                              )
                            ],
                          )
                        : currentRessume?.experiance == null
                            ? SizedBox(
                                height: screenHeight * .2,
                                child: const Center(
                                  child: Text(
                                    'No Data Available',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 10),
                                  ),
                                ),
                              )
                            : Container(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                height: 500,
                                child: ListView(
                                  children: [
                                    CustomListViewExperiance(
                                      jobController: jobController,
                                      enddate: enddate,
                                      startdate: startdate,
                                      companyNameController:
                                          companyNameController,
                                      list: currentRessume?.experiance ?? [],
                                    )
                                  ],
                                )),
                    containershow == false ? Container() : Container()
                  ]),
            ),
          ),
        ));
  }
}
