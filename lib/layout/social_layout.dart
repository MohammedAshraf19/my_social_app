import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialUploadPostState)
          navigateTo(context, NewPostScreen());
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.name[cubit.currentIndex],
              style: TextStyle(
                color: defaultColor.withOpacity(0.8),
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.brightness_medium_outlined,
                    color: defaultColor,
                  ),
                  onPressed: (){
                    SocialCubit.get(context).changeDark();
                  }
              ),
              IconButton(
                  icon: Icon(
                    IconBroken.Notification,
                    color: defaultColor,
                  ),
                  onPressed: (){}
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            iconSize: 28,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                  label: ''
              ),
             /* BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Location,
                  ),
                  label: 'Users'
              ),*/
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: ''
              ),
            ],
          ),
        );
      },
    );
  }
}
/*
ConditionalBuilder(
          condition: SocialCubit.get(context).model !=null,
          builder: (context){
            var model = SocialCubit.get(context).model;
              return Column(
                children: [
                  if(!FirebaseAuth.instance.currentUser.emailVerified)
                    Container(
                  color: Colors.amber.withOpacity(0.6),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Info_Circle,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          'Please Verify Your Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          FirebaseAuth.instance.currentUser.sendEmailVerification().then((value) {
                            showToast(txt: 'Check Your Email', state: ToastState.SUCCESS);
                          }).catchError((error){
                            print(error.toString());
                          });
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
                ],
              );
          },
          fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: defaultColor,)),
        )
*/
