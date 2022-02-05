import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterInit());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_off_outlined;
  var passwordVisibility =true;
  void showPasswordVisibility(){
    passwordVisibility =!passwordVisibility;
    suffixIcon = passwordVisibility?Icons.visibility_off_outlined:Icons.visibility;
    emit(SocialRegisterChangePasswordVisibility());
  }
  void userRegister({
  @required name,
  @required email,
  @required password,
  @required phone,
}){
    emit(SocialRegisterLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
     createUser(
         name: name,
         email: email,
         uId: value.user.uid,
         phone: phone,
     );
   //   emit(SocialRegisterSuccess());
    }).catchError((error){
      emit(SocialRegisterError(error.toString()));
      print(error.toString());
    });
  }
  void createUser({
    @required name,
    @required email,
    @required uId,
    @required phone,
}){
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image: 'https://t3.ftcdn.net/jpg/03/01/94/34/240_F_301943459_hZqG7C4F3nnACx811k2CwS4YfomRT1n1.jpg',
      cover: 'https://t4.ftcdn.net/jpg/04/48/64/71/240_F_448647180_fwUKS89mZGqU46lRTIcpAFETE0Sy3Aqh.jpg',
      bio: 'Write Your Bio...'
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreateUserSuccess());
    })
        .catchError((error){
          emit(SocialCreateUserError(error.toString()));
    });
}
}