// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAccountAdapter extends TypeAdapter<UserAccount> {
  @override
  final int typeId = 0;

  @override
  UserAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAccount(
      username: fields[0] as String,
      password: fields[1] as String,
      userid: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserAccount obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.userid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResumeDataAdapter extends TypeAdapter<ResumeData> {
  @override
  final int typeId = 1;

  @override
  ResumeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResumeData(
      education: (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<int, String>())
          .toList(),
      experiance: (fields[2] as List)
          .map((dynamic e) => (e as Map).cast<int, String>())
          .toList(),
      profileimage: fields[4] as String?,
      personal: (fields[0] as Map).cast<int, String>(),
      projects: (fields[3] as List)
          .map((dynamic e) => (e as Map).cast<int, String>())
          .toList(),
      skillsandothers: (fields[5] as List)
          .map((dynamic e) => (e as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as int, (v as List).cast<String>())))
          .toList(),
      ressumeid: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ResumeData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.personal)
      ..writeByte(1)
      ..write(obj.education)
      ..writeByte(2)
      ..write(obj.experiance)
      ..writeByte(3)
      ..write(obj.projects)
      ..writeByte(4)
      ..write(obj.profileimage)
      ..writeByte(5)
      ..write(obj.skillsandothers)
      ..writeByte(7)
      ..write(obj.ressumeid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CustomUserDataAdapter extends TypeAdapter<CustomUserData> {
  @override
  final int typeId = 2;

  @override
  CustomUserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomUserData(
      resummes: (fields[0] as List).cast<ResumeData>(),
      userId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomUserData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.resummes)
      ..writeByte(1)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomUserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
