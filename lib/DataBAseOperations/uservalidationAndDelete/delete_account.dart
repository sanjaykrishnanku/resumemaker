import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:resume_maker/DataBAseOperations/Datamodel/user_account.dart';
import 'package:resume_maker/DataBAseOperations/uservalidationAndDelete/validation_user.dart';

Future<void> deleteUserAccount(String userid) async {
  final userAccountBox = await Hive.openBox<UserAccount>('userAccountBox');
  var list = userAccountBox.values.toList();
  List<UserAccount> updatedlist = [];
  if (kDebugMode) {
    print('before deleting $list');
  }
  for (var user in list) {
    if (kDebugMode) {
      print('$userid   (${user.userid})');
    }
    if ('(${user.userid})' != userid) {
      list.remove(user);
      updatedlist.add(user);
      if (kDebugMode) {
        print('removed');
      }
    }
  }
  await userAccountBox.clear();
  await userAccountBox.addAll(updatedlist);
  if (kDebugMode) {
    print('after deleting $updatedlist');
  }
  loggedout();
}


