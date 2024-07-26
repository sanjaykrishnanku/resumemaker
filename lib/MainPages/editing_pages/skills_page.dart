import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/customizedWidgets/text/text_styles.dart';

List<String> skills = [];
List<String> achievements = [];
List<String> interests = [];
List<String> hobbies = [];
List<String> languages = [];
List<String> strengths = [];
List<String> careerObjectives = [];

class SkillsAndOthersPage extends StatefulWidget {
  const SkillsAndOthersPage({super.key});

  @override
  State<SkillsAndOthersPage> createState() => _SkillsAndOthersPageState();
}

class _SkillsAndOthersPageState extends State<SkillsAndOthersPage> {
  Map<String, bool> visibilityMap = {
    'Skills': true,
    'Achievements': false,
    'Interests': false,
    'Hobbies': false,
    'Languages': false,
    'Strengths': false,
    'Career Objectives': false,
  };

  Map<String, List<String>> dataMap = {
    'Skills': skills,
    'Achievements': achievements,
    'Interests': interests,
    'Hobbies': hobbies,
    'Languages': languages,
    'Strengths': strengths,
    'Career Objectives': careerObjectives,
  };
  @override
  void initState() {
    super.initState();
    _loadDataFromResume();
  }

  Future <void >_loadDataFromResume() async  {
    await Future.delayed(Duration.zero);
    // here we have to load the datas while the page loading first time
    setState(() {
  if(currentRessume!=null && currentRessume!.skillsandothers.isNotEmpty){
  
  Map<int, List<String>> skillslist = currentRessume!.skillsandothers[0];
  skills=skillslist[1]??[];
  achievements=skillslist[2]??[];
  interests=skillslist[3]??[];
  hobbies=skillslist[4]??[];
  languages=skillslist[5]??[];
  strengths=skillslist[6]??[];
  careerObjectives=skillslist[7]??[];
        dataMap['Skills'] = skillslist[1] ?? [];
        dataMap['Achievements'] = skillslist[2] ?? [];
        dataMap['Interests'] = skillslist[3] ?? [];
        dataMap['Hobbies'] = skillslist[4] ?? [];
        dataMap['Languages'] = skillslist[5] ?? [];
        dataMap['Strengths'] = skillslist[6] ?? [];
        dataMap['Career Objectives'] = skillslist[7] ?? [];
  print(''' 
            the skilllist have $skills
            the achievment list have $achievements
            the intrestslist have $interests
            the hobbies have $hobbies
            the languages list have $languages
            the strength list have $strengths
            the craeer objective list have $careerObjectives
            the data map is $dataMap ''');
  }
});
    
  }

  void toggleVisibility(String key) {
    setState(() {
      visibilityMap[key] = !visibilityMap[key]!;
    });
  }

  void addItem(String key, String newItem) {
    setState(() {
      dataMap[key]!.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 70, left: 8, right: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
           const  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: HeadingTextstyle(
                    content: 'Skills & Others',
                    fontsize: 30,
                  ),
                ),
                
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ...dataMap.keys.map((key) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkillsTile(
                      item: key,
                      isListVisible: visibilityMap[key]!,
                      onIconPressed: () => toggleVisibility(key),
                      onAddPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddItemDialog(
                              maxline: 3,
                              labelText: key.toLowerCase() != 'languages'
                                  ? key
                                  : 'languages-(1-5) eg:Urdu-5',
                              title: key,
                              onSave: (newItem) {
                                addItem(key, newItem);
                              },
                            );
                          },
                        );
                         visibilityMap[key]!=true?toggleVisibility(key):null;
                      },
                    ),
                    if (visibilityMap[key]!)
                      SkillsList(
                        itemList: dataMap[key]!,
                        setstate: () {
                          setState(() {});
                        },
                      ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class SkillsTile extends StatelessWidget {
  const SkillsTile({
    super.key,
    required this.item,
    required this.isListVisible,
    required this.onIconPressed,
    required this.onAddPressed,
  });
  final String item;
  final bool isListVisible;
  final VoidCallback onIconPressed;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40),
      child: Container(
        decoration: const BoxDecoration(
            // color:  Color.fromARGB(62, 156, 214, 149),
            ),
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: Container(
                  height: 25,
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        blurStyle: BlurStyle.outer,
                        blurRadius: 0.5,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                        color: Colors.black)
                  ]),
                  child: Icon(
                    isListVisible ? Icons.arrow_drop_down : Icons.arrow_right,
                    size: 30,
                    color: const Color.fromARGB(255, 153, 81, 105),
                  ),
                ),
                onPressed: onIconPressed,
              ),
              SizedBox(
                width: 170,
                child: Text(
                  item,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: onAddPressed,
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Color.fromARGB(255, 153, 81, 105),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SkillsList extends StatelessWidget {
  const SkillsList({super.key, required this.itemList, required this.setstate});
  final List<String> itemList;
  final Function setstate;

  @override
  Widget build(BuildContext context) {
    return itemList.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 60.0, right: 60),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(172, 235, 235, 235),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const SizedBox(
                  width: 300, child: Center(child: Text('Add data'))),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 60.0, right: 60),
            child: Container(
              height: itemList.length * 50,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(172, 235, 235, 235),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  TextEditingController itemEditingController =
                      TextEditingController();
                  itemEditingController.text = itemList[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 2.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_right_rounded,
                          size: 15,
                        ),
                        InkWell(
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              itemList[index],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                          onTap: () {
                            // here we set the editing of item list option
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      backgroundColor: Colors.white,
                                      actionsAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Close')),
                                        TextButton(
                                            onPressed: () {
                                              if (itemEditingController
                                                  .text.isNotEmpty) {
                                                itemList[index] =
                                                    itemEditingController.text;
                                                setstate();
                                                Navigator.pop(context);
                                                updateskillsandother();
                                              }
                                            },
                                            child: const Text('Save'))
                                      ],
                                      title: const Text(
                                        'Edit ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: TextField(
                                        controller: itemEditingController,
                                        decoration: InputDecoration(
                                          labelText: 'details',
                                          fillColor: const Color.fromARGB(
                                              255, 231, 231, 231),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: const BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 20,
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ));
                                });
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete'),
                                  backgroundColor: Colors.white,
                                  content: const Text(
                                    'Are you sure you want to delete this item?',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          // here we need to add the delete option from the item list
                                          itemList.removeAt(index);
                                          setstate();
                                          Navigator.pop(context);
                                          updateskillsandother();
                                        },
                                        child: const Text('Delete')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'))
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Color.fromARGB(255, 116, 21, 14),
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }
}

class AddItemDialog extends StatelessWidget {
  const AddItemDialog(
      {super.key,
      required this.title,
      required this.onSave,
      required this.labelText,
      this.maxline});

  final String title;
  final Function(String) onSave;
  final String labelText;
  final int? maxline;

  @override
  Widget build(BuildContext context) {
    TextEditingController itemController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return AlertDialog(
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              onSave(itemController.text);
              Navigator.pop(context);
              updateskillsandother();
            }
          },
          child: const Text('Save'),
        )
      ],
      title: Text(
        'Add $title',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: formKey,
        child: TextFormField(
          maxLines: maxline ?? 1,
          controller: itemController,
          decoration: InputDecoration(
            labelText: labelText,
            fillColor: const Color.fromARGB(255, 231, 231, 231),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

updateskillsandother() {
  if (kDebugMode) {
    print(
        'updating skills and other where current Ressumeid : $currentRessumeId \n ${currentRessume?.skillsandothers} ');
    print(' $skills,$achievements ,$interests,$hobbies,$languages,$strengths,');
  }

  currentRessume?.skillsandothers.clear();
  currentRessume?.skillsandothers.add({
    1: skills,
    2: achievements,
    3: interests,
    4: hobbies,
    5: languages,
    6: strengths,
    7: careerObjectives
  });
  if (kDebugMode) {
    print(
        'after updating skills and other where current Ressumeid : $currentRessumeId \n ${currentRessume?.skillsandothers} ');
  }
}
