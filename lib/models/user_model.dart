import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String name;
  String phone;
  String uId;
  String email;
  bool isEmailVerified;
  String image;
  String cover;
  String bio;

  UserModel({
    this.uId,
    this.email,
    this.phone,
    this.name,
    this.isEmailVerified,
    this.image,
    this.cover,
    this.bio,
});
  UserModel.fromJson(Map<String,dynamic>json){
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    name=json['name'];
    isEmailVerified = json['isEmailVerified'];
    image =json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'cover':cover,
      'bio':bio,
    };
  }
}