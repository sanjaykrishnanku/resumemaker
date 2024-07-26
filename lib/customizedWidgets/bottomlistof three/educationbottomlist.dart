import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/customizedWidgets/datepicker/date_picker.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';

// ignore: must_be_immutable
class CustomListViewEducation extends StatefulWidget {
  CustomListViewEducation({
    super.key,
    required this.list,
    required this.schoolNameController,
    required this.coursedetailsController,
    required this.markcontroller,
    required this.startdate,
  });

  final List<Map<int, String>> list;
  TextEditingController schoolNameController;
  TextEditingController coursedetailsController;
  TextEditingController markcontroller;
  DateTime? startdate;

  @override
  State<CustomListViewEducation> createState() =>
      _CustomListViewEducationState();
}

class _CustomListViewEducationState extends State<CustomListViewEducation> {
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
                  widget.schoolNameController.text =
                      temp.isNotEmpty ? temp[0] ?? '' : '';
                  widget.coursedetailsController.text =
                      temp.isNotEmpty ? temp[2] ?? '' : '';
                  widget.markcontroller.text =
                      temp.isNotEmpty ? temp[3] ?? '' : '';
                  try {
                    widget.startdate = DateFormat('dd-MM-yyyy').parse(
                      temp.isNotEmpty ? temp[1] ?? '' : '',
                    );
                  } catch (e) {
                    widget.startdate = DateTime(2000, 1, 1);
                  }
                  if (kDebugMode) {
                    print(
                        "Original date string: ${temp.isNotEmpty && temp[1] != '' ? temp[1] ?? '2000-01-01' : '2000-01-01'}");
                  }

                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(' Edit Details'), Icon(Icons.edit)],
                    ),
                    content: SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextfield(
                              controller: widget.schoolNameController,
                              screenWidth: 300,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter School/college Name';
                                }
                                return null;
                              },
                              hinttext: 'School/college Name ',
                              textfieldmaxlength: 40,
                              keyboardType: TextInputType.name,
                            ),
                            CustomTextfield(
                              controller: widget.coursedetailsController,
                              hinttext: 'Course details',
                              screenWidth: 300,
                              textfieldmaxlength: 50,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Course Details';
                                }
                                return null;
                              },
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Graduation  Date',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DatePicker(
                                  initialDate: widget.startdate,
                                  onDateSelected: (DateTime selectedDate) {
                                    setState(() {
                                      widget.startdate = selectedDate;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: HeadingTextstyle(
                                      content: 'Mark /Percentage',
                                      fontsize: 15,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(width: 10),
                                CustomTextfield(
                                  controller: widget.markcontroller,
                                  validator: (value) => null,
                                  screenWidth: 200,
                                  customwidth: 150,
                                  hinttext: 'Mark or %',
                                  keyboardType: TextInputType.phone,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Update'),
                        onPressed: () {
                          currentRessume?.education[index] = {
                            0: widget.schoolNameController.text,
                            1: widget.startdate == null
                                ? ' '
                                : DateFormat('dd-MM-yyyy')
                                    .format(widget.startdate!),
                            2: widget.coursedetailsController.text,
                            3: widget.markcontroller.text,
                          };
                          widget.schoolNameController.clear();
                          widget.coursedetailsController.clear();
                          widget.markcontroller.clear();
                          if (kDebugMode) {
                            print(currentRessume?.education);
                          }
                          updateResume();
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            leading: Icon(
              Icons.arrow_right,
              color: fourthcolor,
              size: 50,
            ),
            title: Text(
              temp.isNotEmpty ? temp[0] ?? '' : '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '${temp.isNotEmpty ? temp[2] ?? '' : ''} , ${temp.isNotEmpty ? temp[1] ?? '' : ''}',
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
                      title: const Text('Delete'),
                      content: const Text('Are you sure you want to delete?'),
                      actions: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            if (kDebugMode) {
                              print(currentRessume?.experiance);
                            }
                            currentRessume?.education.removeAt(index);
                            updateResume();
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
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
