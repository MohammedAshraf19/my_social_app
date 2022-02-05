import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_Screen.dart';
import 'package:social_app/modules/login/social_login.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/compnents/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        SocialCubit cubit = SocialCubit.get(context);
        return Column(
          children: [
            Container(
              height: 190,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image:NetworkImage(
                            '${cubit.model.cover}',
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 140,

                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 59,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        '${cubit.model.image}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              '${cubit.model.name}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 7,
            ),
            Text(
                '${cubit.model.bio}',//'${cubit.model.bio}',
                style:Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 13
                )
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Posts',
                              style:Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 14
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '2k',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Followers',
                              style:Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 14
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '400',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Followings',
                              style:Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 14
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){},
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Photos',
                              style:Theme.of(context).textTheme.caption.copyWith(
                                  fontSize: 14
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: (){
                    },
                    child: Text(
                      'Add Photo',
                      style: TextStyle(
                          color: Colors.deepOrange
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit_Square,
                      color: Colors.deepOrange,
                    )
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: (){
                        SignOut(context);
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.deepOrange
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
