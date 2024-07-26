import 'package:hive/hive.dart';
part 'user_account.g.dart';

@HiveType(typeId: 0)
class UserAccount {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String userid;
  UserAccount(
      {required this.username, required this.password, required this.userid});
}

@HiveType(typeId: 1)
class ResumeData {
  @HiveField(0)
  Map<int, String> personal = {};
  @HiveField(1)
  List<Map<int, String>> education = [];
  @HiveField(2)
  List<Map<int, String>> experiance = [];
  @HiveField(3)
  List<Map<int, String>> projects = [];
  @HiveField(4)
  String? profileimage;
  @HiveField(5)
  List<Map<int, List<String>>> skillsandothers = [];
  @HiveField(7)
  String ressumeid;

  ResumeData(
      {required this.education,
      required this.experiance,
      required this.profileimage,
      required this.personal,
      required this.projects,
      required this.skillsandothers,
      required this.ressumeid});
}

@HiveType(typeId: 2)
class CustomUserData {
  @HiveField(0)
  List<ResumeData> resummes;

  @HiveField(1)
  String userId;

  CustomUserData({required this.resummes, required this.userId});
}
