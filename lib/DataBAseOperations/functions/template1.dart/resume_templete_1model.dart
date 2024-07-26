import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';
import 'package:resume_maker/DataBAseOperations/functions/template1.dart/resumemodel_1_height_calc.dart';

class ResumeModel1Preview extends StatelessWidget {
  const ResumeModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;

  @override
  Widget build(BuildContext context) {
    List<Widget> resumemodel1previewLeftSection = [];
    List<Widget> resumeModel1previewRightSection = [];
    List<Widget> resumeModel1PreviewbottomSection = [];
    resumeModel1PreviewLeftandRightSectionListAssign(
        resumemodel1previewLeftSection,
        resumeModel1previewRightSection,
        resumeModel1PreviewbottomSection,
        resumeData);
    return SingleChildScrollView(
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
                padding: const EdgeInsets.only(right: 8.0, bottom: 15),
                child: Text(
                  resumeData.personal.isNotEmpty
                      ? resumeData.personal[0] ?? ''
                      : '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 40.0),
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            ProfileImageANdDetailSectionOfModel1Preview(
                              resumeData: resumeData,
                            ),
                            ObjectiveSectionOfModel1Preview(
                                resumeData: resumeData),
                            LanguageSectionOfModel1Preview(
                              resumeData: resumeData,
                            ),
                            SkillSectionOfModel1preview(resumeData: resumeData),
                            Column(children: resumemodel1previewLeftSection)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 220, top: 75.0),
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          children: resumeModel1previewRightSection,
                        ),
                      ),
                    )
                  ],
                ),
              
              const SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Text('1'),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 650.0),
            child: SizedBox(
                width: 500,
                height: 650,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  children: resumeModel1PreviewbottomSection,
                )),
          )
        ],
      ),
    );
  }
}

resumeModel1PreviewLeftandRightSectionListAssign(
    List<Widget> leftsection,
    List<Widget> rightsection,
    List<Widget> bottomSection,
    ResumeData resumeData) {
// resumeData=currentRessume!;
  double currentheightofresume1 = 0;
  currentheightofresume1 += leftsectionHeightOfResume1;
  print('''inside resumemodel 1 previewlistassign
          currnthgt: $currentheightofresume1''');
  sectionHeights.forEach((section, height) {
    currentheightofresume1 += height;
    print('''currnthgt: $currentheightofresume1
            section: $section,height: $height''');
    if (currentheightofresume1 < 600) {
      switch (section) {
        case 'ExperianceSection':
          {
            leftsection.add(
                WorkExperianceSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'EducationSection':
          {
            leftsection
                .add(EducationSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'ProjectSection':
          {
            leftsection
                .add(ProjectSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'AchievementSection':
          {
            leftsection
                .add(AchievementSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'InterestSection':
          {
            leftsection
                .add(IntrestSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'HobbiesSection':
          {
            leftsection
                .add(HobbiesSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'StrengthSection':
          {
            leftsection
                .add(StrengthSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'DeclarationSection':
          {
            leftsection
                .add(DeclarationSectionOfModel1Preview(resumeData: resumeData));
          }
      }
    }
    if (currentheightofresume1 < 1200 && currentheightofresume1 >= 600) {
      switch (section) {
        case 'ExperianceSection':
          {
            rightsection.add(
                WorkExperianceSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'EducationSection':
          {
            rightsection
                .add(EducationSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'ProjectSection':
          {
            rightsection
                .add(ProjectSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'AchievementSection':
          {
            rightsection
                .add(AchievementSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'InterestSection':
          {
            rightsection
                .add(IntrestSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'HobbiesSection':
          {
            rightsection
                .add(HobbiesSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'StrengthSection':
          {
            rightsection
                .add(StrengthSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'DeclarationSection':
          {
            rightsection
                .add(DeclarationSectionOfModel1Preview(resumeData: resumeData));
          }
      }
    }

    if (currentheightofresume1 >= 1200) {
      switch (section) {
        case 'ExperianceSection':
          {
            bottomSection.add(
                WorkExperianceSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'EducationSection':
          {
            bottomSection
                .add(EducationSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'ProjectSection':
          {
            bottomSection
                .add(ProjectSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'AchievementSection':
          {
            bottomSection
                .add(AchievementSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'InterestSection':
          {
            bottomSection
                .add(IntrestSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'HobbiesSection':
          {
            bottomSection
                .add(HobbiesSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'StrengthSection':
          {
            bottomSection
                .add(StrengthSectionOfModel1Preview(resumeData: resumeData));
          }
        case 'DeclarationSection':
          {
            bottomSection
                .add(DeclarationSectionOfModel1Preview(resumeData: resumeData));
          }
      }
    }
  });
}

class ProfileImageANdDetailSectionOfModel1Preview extends StatelessWidget {
  const ProfileImageANdDetailSectionOfModel1Preview(
      {super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          resumeData.profileimage != null && resumeData.profileimage!.isNotEmpty
              ? Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: MemoryImage(
                          File(resumeData.profileimage!).readAsBytesSync()),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox(height: 100),
          const SizedBox(height: 10),
          const Text(
            'Phone',
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
          ),
          Text(
            '${resumeData.personal.isNotEmpty ? resumeData.personal[1] ?? '' : ''},\n${resumeData.personal.isNotEmpty ? resumeData.personal[2] ?? '' : ''}',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 12),
          if (resumeData.personal.isNotEmpty && resumeData.personal[9] != null)
            const Text(
              'Date Of Birth',
              style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal),
            ),
          if (resumeData.personal.isNotEmpty && resumeData.personal[9] != null)
            Text(
              resumeData.personal[9] ?? '',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 12),
          const Text(
            'Address',
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            width: 130,
            child: Text(
              textAlign: TextAlign.center,
              '${resumeData.personal.isNotEmpty ? resumeData.personal[4] ?? '' : ''}  ${resumeData.personal.isNotEmpty ? resumeData.personal[5] ?? '' : ''}, ${resumeData.personal.isNotEmpty ? resumeData.personal[7] ?? '' : ''}, ${resumeData.personal.isNotEmpty ? resumeData.personal[6] ?? '' : ''}',
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          const CustomDivider(value: 'CONTACT'),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0, top: 4),
                child: Icon(IconData(0xe158), size: 12), // Using Material Icons
              ),
              SizedBox(
                width: 160,
                child: Text(
                  resumeData.personal.isNotEmpty
                      ? resumeData.personal[3] ?? ''
                      : '',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ObjectiveSectionOfModel1Preview extends StatelessWidget {
  const ObjectiveSectionOfModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(children: [
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
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )),
      ]),
    );
  }
}

class LanguageSectionOfModel1Preview extends StatelessWidget {
  const LanguageSectionOfModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 185,
        child: Column(
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
                                      Shadow(
                                          blurRadius: .5, color: Colors.black)
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
        ));
  }
}

class SkillSectionOfModel1preview extends StatelessWidget {
  const SkillSectionOfModel1preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(children: [
        const SizedBox(height: 8),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(1))
          if (resumeData.skillsandothers[0][1]!.isNotEmpty)
            const CustomDivider(value: 'SKILLS'),
        const SizedBox(height: 8),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(1))
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: resumeData.skillsandothers[0][1]!
                    .map(
                      (skill) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                            width: double.maxFinite - 20,
                            child: Row(
                              children: [
                                const Icon(IconData(0xe5e1), size: 8),
                                Text(
                                  '  $skill',
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )),
                      ),
                    )
                    .toList(),
              )),
      ]),
    );
  }
}

class WorkExperianceSectionOfModel1Preview extends StatelessWidget {
  const WorkExperianceSectionOfModel1Preview(
      {super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 185,
      child: Column(
        children: [
          if (resumeData.experiance.isNotEmpty)
            const CustomDivider(value: 'WORK EXPERIENCE'),
          if (resumeData.experiance.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resumeData.experiance.map((exp) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, top: 8),
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
      ),
    );
  }
}

class EducationSectionOfModel1Preview extends StatelessWidget {
  const EducationSectionOfModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 185,
      child: Column(children: [
        const SizedBox(height: 8),
        if (resumeData.education.isNotEmpty)
          const CustomDivider(value: 'EDUCATION'),
        if (resumeData.education.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.education.map((edu) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        'Graduation: ${edu[1] != null ? edu[1]! : ''}',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 130,
                          child: Text(
                            edu[0] ?? '',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: Text(
                            'Course: ${edu[2] ?? ''}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: Text(
                            'Marks: ${edu[3] != null && edu[3]!.isNotEmpty && double.tryParse(edu[3]!) != null ? double.parse(edu[3]!) < 100 ? '${edu[3]} %' : edu[3] : ''}',
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
      ]),
    );
  }
}

class ProjectSectionOfModel1Preview extends StatelessWidget {
  const ProjectSectionOfModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
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

class AchievementSectionOfModel1Preview extends StatelessWidget {
  const AchievementSectionOfModel1Preview(
      {super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          const SizedBox(height: 8),
          if (resumeData.skillsandothers.isNotEmpty &&
              resumeData.skillsandothers[0].containsKey(2))
            if (resumeData.skillsandothers[0][2]!.isNotEmpty)
              const CustomDivider(value: 'ACHIEVEMENTS'),
          if (resumeData.skillsandothers.isNotEmpty &&
              resumeData.skillsandothers[0].containsKey(2) &&
              resumeData.skillsandothers[0][2]!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resumeData.skillsandothers[0][2]!
                  .map((achievement) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            achievement,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class IntrestSectionOfModel1Preview extends StatelessWidget {
  const IntrestSectionOfModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(children: [
        const SizedBox(height: 8),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(3))
          if (resumeData.skillsandothers[0][3]!.isNotEmpty)
            const CustomDivider(value: 'INTRESTS'),
        if (resumeData.skillsandothers.isNotEmpty &&
            resumeData.skillsandothers[0].containsKey(3) &&
            resumeData.skillsandothers[0][3]!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resumeData.skillsandothers[0][3]!
                .map((achievement) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        width: 180,
                        child: Text(
                          achievement,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ))
                .toList(),
          ),
      ]),
    );
  }
}

class HobbiesSectionOfModel1Preview extends StatelessWidget {
  const HobbiesSectionOfModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          if (resumeData.skillsandothers.isNotEmpty &&
              resumeData.skillsandothers[0].containsKey(4))
            if (resumeData.skillsandothers[0][4]!.isNotEmpty)
              const CustomDivider(value: 'HOBBIES'),
          if (resumeData.skillsandothers.isNotEmpty &&
              resumeData.skillsandothers[0].containsKey(4) &&
              resumeData.skillsandothers[0][4]!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resumeData.skillsandothers[0][4]!
                  .map((achievement) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            achievement,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class StrengthSectionOfModel1Preview extends StatelessWidget {
  const StrengthSectionOfModel1Preview({super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          const SizedBox(height: 8),
          if (resumeData.skillsandothers.isNotEmpty &&
              resumeData.skillsandothers[0].containsKey(6))
            if (resumeData.skillsandothers[0][6]!.isNotEmpty)
              const CustomDivider(value: 'STRENGTH'),
          if (resumeData.skillsandothers.isNotEmpty &&
              resumeData.skillsandothers[0].containsKey(6) &&
              resumeData.skillsandothers[0][6]!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: resumeData.skillsandothers[0][6]!
                  .map((achievement) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            achievement,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class DeclarationSectionOfModel1Preview extends StatelessWidget {
  const DeclarationSectionOfModel1Preview(
      {super.key, required this.resumeData});
  final ResumeData resumeData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          const SizedBox(height: 8),
          const CustomDivider(value: 'DECLARATIONS'),
          const SizedBox(height: 8),
          const Text(
            'I hereby certify that the above information is true and correct to the best of my knowledge and belief.',
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(
            width: 180,
            child: Text(
              resumeData.personal.isNotEmpty
                  ? resumeData.personal[0] ?? ''
                  : '',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
