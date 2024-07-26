import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';
import 'package:resume_maker/DataBAseOperations/uservalidationAndDelete/validation_user.dart';

String currentUserId = '0';
List<ResumeData>? ressumes;
String? currentRessumeId;
ResumeData? currentRessume;

// ignore: non_constant_identifier_names
Future<void> fetchresumes(Function Fetchdata) async {
  // **fetches the current user ressumes and assign to a global list of resumedatas**

  var resumedatabox = await Hive.openBox<ResumeData>('ressumedata');
  List<ResumeData> userResumes = resumedatabox.values
      .where((resume) => resume.ressumeid.startsWith('$currentUserId-'))
      .toList();
  ressumes = userResumes.isEmpty ? null : userResumes;
  Fetchdata(); // Assign the resumelist
}

Future<void> addRessume(String name) async {
  //** this will add a new ressume when the user want to create a new resume**

  var resumedatabox = await Hive.openBox<ResumeData>('ressumedata');
  String uniqueResumeId = generateUniqueResumeId();

  currentRessumeId = uniqueResumeId;
  // **create a empty new ressume data**
  final resumeData = ResumeData(
    education: [],
    experiance: [],
    personal: {},
    profileimage: '',
    projects: [],
    skillsandothers: [],
    ressumeid: uniqueResumeId,
  );
  resumeData.personal[0] = name;
  currentRessumeId = uniqueResumeId;
  await resumedatabox.put(uniqueResumeId, resumeData);
}

Future<void> updateResume() async {
  var resumedatabox = await Hive.openBox<ResumeData>('ressumedata');
  if (kDebugMode) {
    print(
        'currentressume :$currentRessumeId,currentresume:${currentRessume?.personal}');
  }
  if (currentRessumeId != null) {
    // ResumeData currentResume = resumedatabox.get(currentRessumeId)!;

    if (kDebugMode) {
      print('Updated resume: ${currentRessume?.personal}');
    }

    // Save the updated resume data back to the Hive box
    await resumedatabox.put(currentRessumeId, currentRessume!);
  }
  
}

Future<void> fetchResume() async {
  var resumedatabox = await Hive.openBox<ResumeData>('ressumedata');
  if (kDebugMode) {
    print(
        'currentressume :$currentRessumeId,currentresume:${currentRessume?.personal}');
  }
  currentRessume = resumedatabox.get(currentRessumeId);
}

Future<void> deleteResume() async {
  var resumedatabox = await Hive.openBox<ResumeData>('ressumedata');

  if (currentRessumeId != null) {
    await resumedatabox.delete(currentRessumeId);

    if (kDebugMode) {
      print('Deleted resume with ID: $currentRessumeId');
    }
    currentRessumeId = null;
  }
}
