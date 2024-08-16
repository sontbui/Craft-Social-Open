import 'package:clone_gpt/contains/constains.dart';

class UserModel {
  String uid;
  String fullName;
  String profileImage;
  String phonenumber;
  String bio;
  String dateJoined;
  String dob;
  String lastLogin;
  bool isActive;
  UserModel({
    required this.uid,
    required this.fullName,
    required this.profileImage,
    required this.dateJoined,
    required this.bio,
    required this.dob,
    required this.lastLogin,
    required this.phonenumber,
    required this.isActive,
  });
  Map<String, dynamic> toMap() {
    return {
      Constains.uid: uid,
      Constains.fullName: fullName,
      Constains.profileImage: profileImage,
      Constains.dateJoined: dateJoined,
      Constains.bio: bio,
      Constains.dob: dob,
      Constains.lastLogin: lastLogin,
      Constains.phonenumber: phonenumber,
      Constains.isActice: isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data[Constains.uid] ?? '',
      fullName: data[Constains.fullName] ?? '',
      profileImage: data[Constains.profileImage] ?? '',
      dateJoined: data[Constains.dateJoined] ?? '',
      bio: data[Constains.bio] ?? '',
      dob: data[Constains.dob] ?? '',
      lastLogin: data[Constains.lastLogin] ?? '',
      phonenumber: data[Constains.phonenumber] ?? '',
      isActive: data[Constains.isActice] ?? false,
    );
  }
}
