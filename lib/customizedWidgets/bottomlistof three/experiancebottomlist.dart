import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/customizedWidgets/datepicker/date_picker.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';

// ignore: must_be_immutable
class CustomListViewExperiance extends StatefulWidget {
  CustomListViewExperiance({
    super.key,
    required this.list,
    required this.companyNameController,
    required this.jobController,
    required this.startdate,
    required this.enddate,
  });

  final List<Map<int, String>> list;
  TextEditingController companyNameController;
  TextEditingController jobController;
  DateTime? startdate;
  DateTime? enddate;

  @override
  State<CustomListViewExperiance> createState() =>
      _CustomListViewExperianceState();
}

class _CustomListViewExperianceState extends State<CustomListViewExperiance> {
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
                  widget.companyNameController.text =
                      temp.isNotEmpty ? temp[0] ?? '' : '';
                  widget.jobController.text =
                      temp.isNotEmpty ? temp[1] ?? '' : '';
                  try {
                    widget.startdate = DateFormat('dd-MM-yyyy').parse(
                      temp.isNotEmpty ? temp[2] ??  DateTime.now().toString() : DateTime.now().toString(),
                    );
                  } catch (e) {
                    widget.startdate = DateTime.now();
                  }

                  try {
                    widget.enddate = DateFormat('dd-MM-yyyy').parse(
                      temp.isNotEmpty ? temp[3] ?? DateTime.now().toString() : DateTime.now().toString(),
                    );
                  } catch (e) {
                    widget.enddate = DateTime.now();
                  }

                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Edit Details'), Icon(Icons.edit)],
                    ),
                    content: SizedBox(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextfield(
                              controller: widget.companyNameController,
                              screenWidth: 300,
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
                              controller: widget.jobController,
                              hinttext: 'Job Role',
                              screenWidth: 300,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Joining Date',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 10),
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
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'End Date',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                DatePicker(
                                  initialDate: widget.enddate,
                                  onDateSelected: (DateTime selectedDate) {
                                    setState(() {
                                      widget.enddate = selectedDate;
                                    });
                                  },
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
                          if (kDebugMode) {
                            print("Saving data: ");
                            print("Company: ${widget.companyNameController.text}");
                            print("Job: ${widget.jobController.text}");
                            print("Start Date: ${widget.startdate}");
                            print("End Date: ${widget.enddate}");
                          }

                          currentRessume?.experiance[index] = {
                            0: widget.companyNameController.text,
                            1: widget.jobController.text.toUpperCase(),
                            2: widget.startdate == null
                                ? ' '
                                : DateFormat('dd-MM-yyyy')
                                    .format(widget.startdate!),
                            3: widget.enddate == null
                                ? ' '
                                : DateFormat('dd-MM-yyyy')
                                    .format(widget.enddate!),
                          };
                          updateResume();

                          Navigator.pop(context);
                          setState(() {});
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
              '${temp.isNotEmpty ? temp[1]?.toUpperCase() ?? '' : ''} , ${temp.isNotEmpty ? temp[2] ?? '' : ''} - ${temp.isNotEmpty ? temp[3] ?? '' : ''}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_sharp),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: const Text('Delete'),
                      content: const Text('Are you sure you want to delete?'),
                      actions: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            if (kDebugMode) {
                              print(currentRessume?.experiance);
                            }
                            currentRessume?.experiance.removeAt(index);
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
