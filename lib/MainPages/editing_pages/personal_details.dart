import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/MainPages/foundationpages/editing_page.dart';
import 'package:resume_maker/customizedWidgets/text/custom_textfield.dart';
import 'package:resume_maker/customizedWidgets/dropdownlist/dropdownlist.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/DataBAseOperations/random%20%20datas/indian_states.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController permenantaddresscontroller = TextEditingController();
  TextEditingController addressCityAreacontroller = TextEditingController();
  TextEditingController alternatecontactcontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  String? selectedState;
  String? selectedDistrict;
  String? gender;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  Future<void> _loadData() async {
    setState(() {
      if (currentRessume != null && currentRessume?.personal != null) {
        final personalData = currentRessume?.personal;

        namecontroller.text = personalData?[0] ?? '';
        phonecontroller.text = personalData?[1] ?? '';
        alternatecontactcontroller.text = personalData?[2] ?? '';
        emailcontroller.text = personalData?[3] ?? '';

        permenantaddresscontroller.text = personalData?[4] ?? '';
        addressCityAreacontroller.text = personalData?[5] ?? '';
        selectedState = personalData?[6] ?? 'State';
        districtcontroller.text = personalData?[7] ?? '';
        gender = personalData?[8] ?? '';
        dateofbirth.text = personalData?[9] ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               const HeadingTextstyle(
                fontsize: 30,
                content: '   Personal Details',
              ),
            
            const SizedBox(
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top:20.0,bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: fourthcolor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextButton(
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        currentRessume?.personal[0] = namecontroller.text;
                        currentRessume?.personal[1] = phonecontroller.text;
                        currentRessume?.personal[2] =
                            alternatecontactcontroller.text;
                        currentRessume?.personal[3] = emailcontroller.text;
                        currentRessume?.personal[4] =
                            permenantaddresscontroller.text;
                        currentRessume?.personal[5] =
                            addressCityAreacontroller.text;
                        currentRessume?.personal[6] = selectedState ?? '';
                        currentRessume?.personal[7] = districtcontroller.text;
                        currentRessume?.personal[8] = gender ?? '';
                        currentRessume?.personal[9] = dateofbirth.text;
              
                        updateResume();
                        setState(() {
                          if (currentindex < 6 && currentindex >= 0) {
                            currentindex = currentindex + 1;
              
                            pagecontroller.jumpToPage(currentindex);
                          }
                        });
              
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added successfully'),
                            duration: Duration(milliseconds: 600),
                            backgroundColor: Color.fromARGB(255, 158, 158, 158),
                            width: 200,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              width: screenWidth,
              color: Colors.white,
              child: Form(
                key: formkey,
                child: Container(
                  alignment: Alignment.topLeft,
                  width: 350,
                  child: Column(children: [
                    CustomTextfield(
                      controller: namecontroller,
                      hinttext: 'Full Name',
                      screenWidth: screenWidth,
                      keyboardType: TextInputType.name,
                      textfieldmaxlength: 20,
                      padding: const EdgeInsets.only(top: 40),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your UserName';
                        }
                        if (value.trim().length < 5) {
                          return 'atleast 5 characters';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextfield(
                      controller: dateofbirth,
                      hinttext: ' Date Of Birth (DD-MM-YYYY)',
                      screenWidth: screenWidth,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter the Date Of Birth';
                        }
                        return null;
                      },
                      textfieldmaxlength: 10,
                      padding: const EdgeInsets.only(top: 15),
                    ),
                    CustomTextfield(
                      controller: phonecontroller,
                      hinttext: 'Contact Number',
                      screenWidth: screenWidth,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter the phone number';
                        }
                        if (value.trim().length < 10) {
                          return 'please enter valid phone number';
                        }
                        return null;
                      },
                      textfieldmaxlength: 10,
                      padding: const EdgeInsets.only(top: 15),
                    ),
                    CustomTextfield(
                      controller: alternatecontactcontroller,
                      hinttext: 'Alternate Contact Number',
                      screenWidth: screenWidth,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter Alternate Number';
                        }

                        return null;
                      },
                      textfieldmaxlength: 10,
                      padding: const EdgeInsets.only(top: 30),
                    ),
                    CustomTextfield(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      hinttext: 'E-mail',
                      screenWidth: screenWidth,
                      textfieldmaxlength: 40,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter email';
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      controller: permenantaddresscontroller,
                      hinttext: 'Permanent Address',
                      keyboardType: TextInputType.multiline,
                      screenWidth: screenWidth,
                      maxlines: 4,
                      textfieldmaxlength: 70,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter address';
                        }
                        return null;
                      },
                      padding: const EdgeInsets.only(top: 10),
                    ),
                    CustomTextfield(
                      controller: addressCityAreacontroller,
                      keyboardType: TextInputType.streetAddress,
                      hinttext: 'City/area',
                      screenWidth: screenWidth,
                      textfieldmaxlength: 60,
                      maxlines: 2,
                      validator: (value) {
                        return null;
                      },
                      padding: const EdgeInsets.only(top: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropDownList(
                          items: indianStates,
                          selectedValue: selectedState ?? 'State',
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                            });
                          },
                        ),
                        CustomTextfield(
                          controller: districtcontroller,
                          keyboardType: TextInputType.streetAddress,
                          customwidth: 200,
                          maxlines: 1,
                          textfieldmaxlength: 25,
                          hinttext: 'District',
                          screenWidth: screenWidth,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please select';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            fillColor: WidgetStateProperty.all(Colors.amber),
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value as String;
                              });
                            },
                          ),
                          Text(
                            'Male',
                            style: TextStyle(color: black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Radio(
                              fillColor: WidgetStateProperty.all(Colors.amber),
                              value: 'Female',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value as String;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Female',
                            style: TextStyle(color: black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Radio(
                              fillColor: WidgetStateProperty.all(Colors.amber),
                              activeColor: Colors.black,
                              value: 'Others',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value as String;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Others',
                            style: TextStyle(color: black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [],
                    ),
                    const SizedBox(
                      height: 120,
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
