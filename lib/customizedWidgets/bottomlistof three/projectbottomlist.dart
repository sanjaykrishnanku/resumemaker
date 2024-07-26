// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/customizedWidgets/datepicker/date_picker.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';

class CustomListViewProjects extends StatefulWidget {
  CustomListViewProjects(
      {super.key,
      required this.list,
      required this.projectNameController,
      required this.projectDetailsController,
      required this.rolecontroller,
      required this.startdate,
      required this.enddate,
      required this.teamsize});
  final List<Map<int, String>> list;
  TextEditingController projectNameController;
  TextEditingController projectDetailsController;
  TextEditingController rolecontroller;
  DateTime? startdate;
  DateTime? enddate;
  String? teamsize;

  @override
  State<CustomListViewProjects> createState() => _CustomListViewProjectsState();
}

class _CustomListViewProjectsState extends State<CustomListViewProjects> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 310),
      child: ListView.separated(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          Map<int, String> temp = widget.list[index];
          return ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    widget.projectNameController.text =
                        temp.isNotEmpty ? temp[0] ?? '' : '';

                    widget.projectDetailsController.text =
                        temp.isNotEmpty ? temp[1] ?? '' : '';
                    try {
                      widget.startdate = DateFormat('dd-MM-yyyy').parse(
                          temp.isNotEmpty
                              ? temp[2] ?? ' '
                              : ' ');
                    } catch (e) {
                      widget.startdate =null;
                      //  DateTime(2000, 1, 1);
                    }

                    try {
                      widget.enddate = DateFormat('dd-MM-yyyy').parse(
                          temp.isNotEmpty
                              ? temp[3] ?? ''
                              // DateTime.now().toString()
                              // '01-01-2000'
                              : ' ');
                    } catch (e) {
                      widget.enddate = null;
                      // DateTime(2000, 1, 1);
                    }
                    widget.rolecontroller.text =
                        temp.isNotEmpty ? temp[4] ?? '' : '';
                    widget.teamsize = temp.isNotEmpty ? temp[5] ?? '0' : '0';
                    
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(' Edit Details'), Icon(Icons.edit)],
                      ),
                      content: SizedBox(
                        height: 450,
                        width: 500,
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextfield(
                                  controller: widget.projectNameController,
                                  screenWidth: double.maxFinite,
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
                                  controller: widget.projectDetailsController,
                                  hinttext: 'Project Details',
                                  screenWidth: double.maxFinite,
                                  maxlines: 4,
                                  textfieldmaxlength: 100,
                                  keyboardType: TextInputType.multiline,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter Project Details';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextfield(
                                  controller: widget.rolecontroller,
                                  screenWidth: double.maxFinite,
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const HeadingTextstyle(
                                      fontsize: 20,
                                      content: 'Start Date',
                                    ),
                                    DatePicker(
                                      onDateSelected: (DateTime selectedDate) {
                                        setState(() {
                                          widget.startdate = selectedDate;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const HeadingTextstyle(
                                          content: 'End Date', fontsize: 20),
                                      DatePicker(
                                        onDateSelected:
                                            (DateTime selectedDate) {
                                          setState(() {
                                            widget.enddate = selectedDate;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Update'),
                          onPressed: () {
                            currentRessume?.projects[index] = {
                              0: widget.projectNameController.text,
                              1: widget.projectDetailsController.text,
                              2: widget.startdate == null
                                  ? ' '
                                  : DateFormat('dd-MM-yyyy')
                                      .format(widget.startdate!),
                              3: widget.enddate == null
                                  ? ' ' 
                                  : DateFormat('dd-MM-yyyy')
                                      .format(widget.enddate!),
                              
                              4: widget.rolecontroller.text,
                              5: widget.teamsize ?? '0',
                            };
                            updateResume();
                            widget.projectNameController.clear();
                            widget.projectDetailsController.clear();
                            widget.startdate = DateTime(2000, 1, 1);
                            widget.enddate = DateTime(2000, 1, 1);
                            widget.rolecontroller.clear();
                            widget.teamsize = '0';
                            Navigator.pop(context);
                            setState(() {});
                          },
                        ),
                        TextButton(
                          child: const Text('close'),
                          onPressed: () {
                            widget.projectNameController.clear();
                            widget.projectDetailsController.clear();
                            widget.startdate =null;
                                // DateFormat('dd-MM-yyyy').parse('01-01-2000');
                            widget.enddate =
                            null;
                                // DateFormat('dd-MM-yyyy').parse('01-01-2000');
                            widget.rolecontroller.clear();
                            widget.teamsize = '0';
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            },
            leading: Icon(
              Icons.arrow_right,
              color: fourthcolor,
              size: 50,
            ),
            title: Text(
              temp.isNotEmpty
                  ? temp[0] ?? 'tap here to add'
                  : 'tap here to add',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '${temp.isNotEmpty ? temp[2] ?? 'add data' : 'add data'} , ${temp.isNotEmpty ? temp[1] ?? '' : ''}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_sharp),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: const Text('Delete '),
                        content: const Text('Are You Sure want to delete ??'),
                        actions: [
                          TextButton(
                            child: const Text(
                              'Yes',
                            ),
                            onPressed: () {
                              if (kDebugMode) {
                                print(currentRessume?.projects);
                              }
                              currentRessume?.projects.removeAt(index);
                              updateResume();
                              setState(() {});
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'No',
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const Divider(color: Colors.black, height: 2, thickness: 0),
      ),
    );
  }
}
