import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';

Future<bool> validation(String username, String password) async {
  var userAccountBox = await Hive.openBox<UserAccount>('userAccountBox');
  List<UserAccount> userAccounts = userAccountBox.values.toList();
  var isLoggedInBox = await Hive.openBox<bool>('isloggedin');
  var currentuser = await Hive.openBox<String>('currentuserid');

  for (var account in userAccounts) {
    if (kDebugMode) {
      print('username: $username  password: $password');
    }
    if (kDebugMode) {
      print(
          'username: ${account.username.toString()}   password:${account.password.toString()}     userid: ${account.userid.toString()} resumedata: $account');
    }
    if (account.username.toString() == username &&
        account.password.toString() == password) {
      isLoggedInBox.put('isLoggedin', true);
      currentuser.put('currentuser', account.userid);

      if (kDebugMode) {
        print('Data validated successfully ');
      }
      return true;
    }
  }
  if (kDebugMode) {
    print('Data not available ');
  }
  return false;
}

Future<void> saveUserAccount(
    String username, String password, String userId) async {
  final userAccountBox = await Hive.openBox<UserAccount>('userAccountBox');
  var isLoggedInBox = await Hive.openBox<bool>('isloggedin');
  var currentuser = await Hive.openBox<String>('currentuserid');
  final userAccount =
      UserAccount(username: username, password: password, userid: userId);
  userAccountBox.add(userAccount);
  isLoggedInBox.put('isLoggedin', true);
  currentuser.put('currentuser', userId);

  if (kDebugMode) {
    print('Data saved successfully ');
    List<UserAccount> userAccounts = userAccountBox.values.toList();
    for (var element in userAccounts) {
      print(
          'username:${element.username}   password:${element.password}  userid : ${element.userid}');
    }
  }
}

Future<bool?> isloggedin() async {
  var isLoggedInBox = await Hive.openBox<bool>('isloggedin');
  bool? isloggedIn = isLoggedInBox.get('isLoggedin');

  return isloggedIn;
}

Future loggedout() async {
  var isLoggedInBox = await Hive.openBox<bool>('isloggedin');
  isLoggedInBox.put('isLoggedin', false);
  var currentuser = await Hive.openBox<String>('currentuserid');
  currentuser.put('currentuser', '');

  if (kDebugMode) {
    print('logged out  successfully ');
  }
  return null;
}

Future fetchcurrentuser() async {
  var currentuser = await Hive.openBox<String>('currentuserid');
  String currentuserid = currentuser.values.toString();
  currentUserId = currentuserid;
  if (kDebugMode) {
    print('current user added ${currentuserid + currentUserId}');
  }
}


String generateUniqueUserId() {
  final random = Random();
  const characters =
      '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const length = 12; 
  String userId = '';
  for (int i = 0; i < length; i++) {
    userId += characters[random.nextInt(characters.length)];
  }

  return userId;
}

String generateUniqueResumeId( ) {
  final random = Random();
  const characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const length = 3;
  String resumeId = '$currentUserId-'; 
  for (int i = 0; i < length; i++) {
    resumeId += characters[random.nextInt(characters.length)];
  }

  return resumeId;
}
