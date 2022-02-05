import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController =TextEditingController();
  var bioController =TextEditingController();
  var phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = SocialCubit.get(context);
        var profileImage =cubit.profileImage;
        var coverImage = cubit.coverImage;
        nameController.text = cubit.model.name;
        bioController.text =cubit.model.bio;
        phoneController.text = cubit.model.phone;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  color: defaultColor.withOpacity(0.8),
                ),
                onPressed: (){
                  navigatePop(context);
                }
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                  color: defaultColor,
                  fontSize: 22
              ),
            ),
            actions: [
              TextButton(
                onPressed:(){
                  SocialCubit.get(context).updateUser(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                } ,
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    color: defaultColor.withOpacity(0.9),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is SocialUpdateProfileLoadingState)
                  LinearProgressIndicator(backgroundColor: defaultColor,),
                if(state is SocialUpdateProfileLoadingState)
                  SizedBox(
                  height: 10,
                ),
                Container(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: Alignment.topRight,

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image(
                                  image:coverImage==null? NetworkImage(
                                    '${cubit.model.cover}',
                                  ) :FileImage(coverImage),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 140,

                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 17,
                                    )
                                    , onPressed: (){
                                      cubit.getCoverImage();
                                }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 59,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage:profileImage == null? NetworkImage(
                                '${cubit.model.image}',
                              ):FileImage(profileImage),
                            ),
                          ),
                          CircleAvatar(
                            radius: 19,
                            backgroundColor: defaultColor,
                            child: IconButton(
                                icon: Icon(
                                  IconBroken.Camera,
                                  size: 17,
                                )
                                , onPressed: (){
                                  cubit.getProfileImage();
                            }
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                if(cubit.profileImage!=null||(cubit.coverImage!=null))
                  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      if(cubit.profileImage!=null)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius:  BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: TextButton(
                              onPressed: (){
                                cubit.uploadProfileImage(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                              },
                              child: Text(
                                'UPLOAD PROFILE',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      if(cubit.coverImage!=null)
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius:  BorderRadius.circular(12),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            padding: EdgeInsetsDirectional.zero,
                            child: TextButton(
                              onPressed: (){
                                cubit.uploadProfileCover(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                              },
                              child: Text(
                                'UPLOAD COVER',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                defaultTextFormField(
                    hintText: 'Name',
                    prefixIcon: IconBroken.User,
                    Controller: nameController,
                  textInputType: TextInputType.name,
                  validator: (String value){
                      if(value.isEmpty)
                        return 'Name Must\'t Be Empty';
                      else
                        return null;
                  }
                ),
                SizedBox(
                  height: 5,
                ),
                defaultTextFormField(
                    hintText: 'Bio',
                    prefixIcon: IconBroken.Info_Circle,
                    Controller: bioController,
                    textInputType: TextInputType.text,
                    validator: (String value){
                      if(value.isEmpty)
                        return 'Bio Must\'t Be Empty';
                      else
                        return null;
                    }
                ),
                SizedBox(
                  height: 5,
                ),
                defaultTextFormField(
                    hintText: 'Phone',
                    prefixIcon: IconBroken.Call,
                    Controller: phoneController,
                    textInputType: TextInputType.phone,
                    validator: (String value){
                      if(value.isEmpty)
                        return 'Phone Must\'t Be Empty';
                      else
                        return null;
                    }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
