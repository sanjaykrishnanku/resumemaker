import 'dart:io';
import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';

bool isheightCalculatedResume1 = false;
double currentHeightResume1 = 0;
Map<String, double> sectionHeights = {};
double leftsectionHeightOfResume1 = 0;

class ResumeModel1HeightCalculation extends StatelessWidget {
  final ResumeData resumeData;

  const ResumeModel1HeightCalculation({super.key, required this.resumeData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 77, 77, 77),
                        ),
                        height: 60,
                        width: double.maxFinite,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, bottom: 15),
                            child: Text(
                              resumeData.personal.isNotEmpty
                                  ? resumeData.personal[0] ?? ''
                                  : '',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LeftSection(
                            resumeData: resumeData,
                            onHeightCalculated: (height) {
                              leftsectionHeightOfResume1 = height;
                              print('left section height is $height');
                            },
                          ),
                          RightSection(resumeData: resumeData)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class LeftSection extends StatelessWidget {
  const LeftSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 35.0),
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileSection(resumeData: resumeData),
            ContactSection(resumeData: resumeData),
            ObjectiveSection(resumeData: resumeData),
            LanguageSection(resumeData: resumeData),
            SkillsSection(resumeData: resumeData)
          ],
        ),
      ),
    );
  }
}

class RightSection extends StatefulWidget {
  const RightSection({super.key, required this.resumeData});
  final ResumeData resumeData;

  @override
  State<RightSection> createState() => _RightSectionState();
}

class _RightSectionState extends State<RightSection> {
  
  
@override
  void initState() {
    isheightCalculatedResume1 = false;
    currentHeightResume1 = 0;
    sectionHeights.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(currentHeightResume1);
    void updateHeight(String section, double height) {
      if (isheightCalculatedResume1 == false) {
        currentHeightResume1 += height;
        setState(() {
          sectionHeights[section] = height;
          print(''' updating $section : $height''');
          if (sectionHeights.length == 8) {
            isheightCalculatedResume1 = true;
          }
        });
      }
    }

    print('''current total height =$currentHeightResume1''');
    return SizedBox(
      width: 220,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 105),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WorkExperianceSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('ExperianceSection', height),
            ),
            EducationSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('EducationSection', height),
            ),
            ProjectSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('ProjectSection', height),
            ),
            AchievementSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('AchievementSection', height),
            ),
            IntrestsSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('InterestSection', height),
            ),
            HobbiesSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('HobbiesSection', height),
            ),
            StrengthSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('StrengthSection', height),
            ),
            DeclarationSection(
              resumeData: widget.resumeData,
              onHeightCalculated: (height) =>
                  updateHeight('DeclarationSection', height),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        resumeData.profileimage != null && resumeData.profileimage!.isNotEmpty
            ? CircleAvatar(
                backgroundImage: MemoryImage(
                    File(resumeData.profileimage!).readAsBytesSync()),
                radius: 50,
                backgroundColor: Colors.transparent,
              )
            : const SizedBox(
                height: 100,
              ),
        const SizedBox(height: 10),
        const Text(
          'Phone',
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
        ),
        Text(
          '${resumeData.personal.isNotEmpty ? resumeData.personal[1] ?? '' : ''},\n${resumeData.personal.isNotEmpty ? resumeData.personal[2] ?? '' : ''}',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        if (resumeData.personal.isNotEmpty && resumeData.personal[9] != null)
          const Text(
            'Date Of Birth',
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
          ),
        if (resumeData.personal.isNotEmpty && resumeData.personal[9] != null)
          Text(
            resumeData.personal[9] ?? '',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        const SizedBox(height: 12),
        const Text(
          'Address',
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          width: 130,
          child: Text(
            textAlign: TextAlign.center,
            '${resumeData.personal.isNotEmpty ? resumeData.personal[4] ?? '' : ''}  ${resumeData.personal.isNotEmpty ? resumeData.personal[5] ?? '' : ''}, ${resumeData.personal.isNotEmpty ? resumeData.personal[7] ?? '' : ''}, ${resumeData.personal.isNotEmpty ? resumeData.personal[6] ?? '' : ''}',
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        const CustomDivider(value: 'CONTACT'),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0, top: 4),
              child: Icon(Icons.mail, size: 12),
            ),
            SizedBox(
              width: 130,
              child: Text(
                resumeData.personal.isNotEmpty
                    ? resumeData.personal[3] ?? ''
                    : '',
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ObjectiveSection extends StatelessWidget {
  const ObjectiveSection({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(7))
          if (resumeData.skillsandothers[0][7]!.isNotEmpty)
            const CustomDivider(value: 'OBJECTIVE'),
        const SizedBox(height: 5),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(7))
          ...resumeData.skillsandothers[0][7]!.map((objective) => SizedBox(
                width: 120,
                child: Text(
                  objective,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w500),
                ),
              )),
      ],
    );
  }
}

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(5))
          const CustomDivider(value: 'LANGUAGE'),
        const SizedBox(height: 5),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(5))
          ...resumeData.skillsandothers[0][5]!.map((language) {
            var processedLanguage = processLanguageString(language);
            String languageName = processedLanguage['language'];
            int? rating = processedLanguage['rating'];
            return SizedBox(
              width: 120,
              child: Row(
                children: [
                  SizedBox(
                    width: 65,
                    child: Text(
                      languageName,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (rating != null) ...[
                    ...List.generate(
                        rating,
                        (index) => const Icon(
                                shadows: [
                                  Shadow(blurRadius: 1, color: Colors.black)
                                ],
                                Icons.star,
                                size: 10,
                                color: Color.fromARGB(255, 224, 183, 0))),
                    ...List.generate(
                        5 - rating,
                        (index) => const Icon(
                                shadows: [
                                  Shadow(blurRadius: .5, color: Colors.black)
                                ],
                                Icons.star_border,
                                size: 10,
                                color: Color.fromARGB(255, 224, 183, 0))),
                  ],
                ],
              ),
            );
          }).toList(),
      ],
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(1))
          if (resumeData.skillsandothers[0][1]!.isNotEmpty)
            const CustomDivider(value: 'SKILLS'),
        const SizedBox(height: 8),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(1))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.skillsandothers[0][1]!
                .map(
                  (skill) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Row(children: [
                        const Icon(
                          Icons.arrow_right_rounded,
                          size: 10,
                        ),
                        Text(
                          '  $skill',
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal),
                        ),
                      ]),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class WorkExperianceSection extends StatelessWidget {
  const WorkExperianceSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        if (resumeData.experiance.isNotEmpty)
          const CustomDivider(value: 'WORK EXPERIENCE'),
        if (resumeData.experiance.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.experiance.map((exp) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        '${exp[2]} - ${exp[3]}',
                        style: const TextStyle(fontSize: 9.3),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            '${exp[0] != null ? exp[0]!.toUpperCase() : ''} ',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            '${exp[1]} ',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class EducationSection extends StatelessWidget {
  const EducationSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        if (resumeData.education.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: CustomDivider(value: 'EDUCATION'),
          ),
        if (resumeData.education.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.education.map((edu) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        'Date: ${edu[1] ?? ''}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 140,
                          child: Text(
                            edu[0] ?? '',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            'Course: ${edu[2] ?? ''}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            'Marks: ${edu[3] ?? ''}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class ProjectSection extends StatelessWidget {
  const ProjectSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        if (resumeData.projects.isNotEmpty)
          const CustomDivider(value: 'PROJECTS'),
        if (resumeData.projects.isNotEmpty)
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resumeData.projects.map((proj) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        '${proj[2] ?? ''}-\n${proj[3]}',
                        style: const TextStyle(fontSize: 9),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            proj[0] != null ? proj[0]!.toUpperCase() : '',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${proj[1] ?? ''}\nTeam size: ${proj[5] ?? ''}\n Role:${proj[4]}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class AchievementSection extends StatelessWidget {
  const AchievementSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(2))
          if (resumeData.skillsandothers[0][2]!.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CustomDivider(value: 'ACHIEVEMENTS'),
            ),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(2) &&
            resumeData.skillsandothers[0][2]!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.skillsandothers[0][2]!
                .map((achievement) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          achievement,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}

class IntrestsSection extends StatelessWidget {
  const IntrestsSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(3))
          if (resumeData.skillsandothers[0][3]!.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CustomDivider(value: 'INTRESTS'),
            ),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(3) &&
            resumeData.skillsandothers[0][3]!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.skillsandothers[0][3]!
                .map((achievement) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          achievement,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}

class HobbiesSection extends StatelessWidget {
  const HobbiesSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(4))
          if (resumeData.skillsandothers[0][4]!.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CustomDivider(value: 'HOBBIES'),
            ),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(4) &&
            resumeData.skillsandothers[0][4]!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.skillsandothers[0][4]!
                .map((achievement) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          achievement,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}

class StrengthSection extends StatelessWidget {
  const StrengthSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(6))
          if (resumeData.skillsandothers[0][6]!.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: CustomDivider(value: 'STRENGTH'),
            ),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(6) &&
            resumeData.skillsandothers[0][6]!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.skillsandothers[0][6]!
                .map((achievement) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          achievement,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ))
                .toList(),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class DeclarationSection extends StatelessWidget {
  const DeclarationSection(
      {super.key, required this.resumeData, required this.onHeightCalculated});
  final ResumeData resumeData;
  final Function(double) onHeightCalculated;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      onHeightCalculated(box.size.height);
    });
    return Column(
      children: [
        const CustomDivider(value: 'DECLARATIONS'),
        const SizedBox(height: 8),
        const Text(
          'I hereby certify that the above information is true and correct to the best of my knowledge and belief.',
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(
          width: 160,
          child: Text(
            resumeData.personal.isNotEmpty ? resumeData.personal[0] ?? '' : '',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: Color.fromARGB(255, 77, 77, 77),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 3, top: 5),
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

Map<String, dynamic> processLanguageString(String language) {
  if (language.length > 1) {
    String lastChar = language[language.length - 1];
    if (RegExp(r'^[1-5]$').hasMatch(lastChar)) {
      String processedLanguage = language.substring(0, language.length - 2);
      return {'language': processedLanguage, 'rating': int.parse(lastChar)};
    }
  }
  return {'language': language, 'rating': null};
}
