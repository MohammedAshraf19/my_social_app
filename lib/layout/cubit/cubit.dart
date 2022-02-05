import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/setting/settind_screen.dart';
import 'package:social_app/modules/users/user_screen.dart';
import 'package:social_app/shared/compnents/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialInit());
  static SocialCubit get(context)=>BlocProvider.of(context);
  UserModel model ;
  void getUserData(){
    emit(SocialGetUserLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          model = UserModel.fromJson(value.data());
          emit(SocialGetUserSuccess());
    })
        .catchError((error){
          emit(SocialGetUserError(error.toString()));
    });
  }

  int currentIndex =0;
  List<Widget>screen =[
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
   // UsersScreen(),
    SettingScreen(),
  ];
  List<String>name =[
    'Home',
    'Chats',
    'Post',
   // 'Users',
    'Setting',
  ];
  void changeBottomNav(int index){
    if(index==1)
      getAllUsers();
    if(index==2)
      emit(SocialUploadPostState());
    else{
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }
  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }
  File coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required name,
    @required bio,
    @required phone,
}){
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value){
          value.ref.getDownloadURL()
              .then((value) {
                print(value);
                updateUser(
                    name: name,
                    bio: bio,
                    phone: phone,
                  image: value,
                );
              //  emit(SocialUploadProfileImageSuccessState());
          })
              .catchError((error){
            print(error);
                emit(SocialUpdateProfileErrorState());
          }
          );
    })
        .catchError((error){
          print(error);
      emit(SocialUpdateProfileErrorState());
    });
  }

  void uploadProfileCover({
    @required name,
    @required bio,
    @required phone,
}){
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        print(value);
        updateUser(
            name: name,
            bio: bio,
            phone: phone,
          cover: value
        );
       // emit(SocialUploadCoverImageSuccessState());
      })
          .catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

  /*void updateProfile({
    @required name,
    @required bio,
    @required phone,
}){
    emit(SocialUpdateProfileLoadingState());
    if(coverImage!=null){
      uploadProfileCover();
    }
    else if(profileImage !=null){
      uploadProfileImage();
    }
    else if(coverImage!=null&&profileImage !=null){
      uploadProfileCover();
      uploadProfileImage();
    }
    else{
     updateUser(
         name: name,
         bio: bio,
         phone: phone);
    }

  }*/
  void updateUser({
    @required name,
    @required bio,
    @required phone,
    String image,
    String cover,
  }){
    emit(SocialUpdateProfileLoadingState());
    UserModel usermodel = UserModel(
        email: model.email,
        name: name,
        phone: phone,
        uId: model.uId,
        image:image?? model.image,
        cover:cover?? model.cover,
        bio: bio,
        isEmailVerified: false
    );
    FirebaseFirestore.instance.collection('users')
        .doc(model.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(SocialUpdateProfileErrorState());
    });
  }

  // Post

  File postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialUpdatePostImageLoadingState());
    } else {
      print('No image selected.');
      emit(SocialUpdatePostImageErrorState());
    }
  }

  void uploadPostImage({
    @required dateText,
    @required text,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
            createPost(
                dateText: dateText
                , text: text,
              postImage: value
            );
      })
          .catchError((error){
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    @required String dateText,
    String postImage,
    @required String text,
  }){
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
        name: model.name,
        uId: model.uId,
        text: text,
        dateTime:dateText,
        postImage: postImage??'',
        image:model.image,

    );
    FirebaseFirestore.instance.collection('posts')
        .add(postModel.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
  List<PostModel>posts=[];
  void removePostImage(){
    postImage =null;
    emit(SocialRemovePostImageState());
  }
  void getPosts(){
    emit(SocialGetPostsLoading());
    FirebaseFirestore.instance
    .collection('posts')
    .get()
    .then((value) {
      value.docs.forEach((element) { 
        element.reference
        .collection('comments')
        .get()
        .then((value) {
          comment.add(value.docs.length);
        })
        .catchError((onError){});
      });
      value.docs.forEach((element) { 
        element.reference
        .collection('likes')
        .get()
        .then((value) {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          posId.add(element.id);
        })
        .catchError((error){

        });
      });
      emit(SocialGetPostsSuccess());
    })
    .catchError((error){
      emit(SocialGetPostsError(error.toString()));
    });
  }

  List<String>posId=[];
  List<int> likes =[];
  void likePost(String postId){
    FirebaseFirestore.instance
    .collection('posts')
    .doc(postId)
    .collection('likes')
     .doc(model.uId)
     .set({
      'like':true,
    })
     .then((value) {
       emit(SocialLikePostSuccessState());
    })
     .catchError((onError){
       emit(SocialLikePostErrorState());
    });
  }
  List<int>comment =[];
  void commentPost(String postId){
    FirebaseFirestore.instance
    .collection('posts')
    .doc(postId)
    .collection('comments')
    .doc(model.uId)
    .set({
      'comment':true,
    })
    .then((value){
      emit(SocialCommentPostSuccessState());
    })
    .catchError((error){
      emit(SocialCommentPostErrorState());
    });

  }

  List<UserModel> users=[];
  void getAllUsers(){
    emit(SocialGetAllUsersLoadind());
    if(users.length==0)
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId']!=model.uId)
          users.add(UserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccess());
    })
        .catchError((error){
      emit(SocialGetAllUsersError(error.toString()));
    });
  }
  void sendMessage({
  @required String text,
    @required String dateTime,
    @required String receiverId,
}){
    MessageModel messageModel = MessageModel(
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: model.uId,
      text: text
    );

    FirebaseFirestore.instance
    .collection('users')
    .doc(model.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(messageModel.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }
  List<MessageModel> messages =[] ;
  void getMessage({
  @required String receiverId,
}){
    FirebaseFirestore.instance
    .collection('users')
    .doc(model.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots()
    .listen((event) {
      messages =[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  bool isDark=false;
  void changeDark({bool fromShared}){
    if(fromShared !=null){
      isDark=fromShared;
      emit(ChangeMode());
    }
    else{
      isDark=!isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeMode());
      });
    }
  }
}