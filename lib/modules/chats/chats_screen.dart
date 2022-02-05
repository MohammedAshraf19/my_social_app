import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details_screen/chat_details_screen.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length>0,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index){
              return buildChat(SocialCubit.get(context).users[index],context);
            },
            separatorBuilder: (context,index){
              return  Container(
                width: double.infinity,
                height: 1,
                padding: EdgeInsets.all(20),
                color: Colors.deepOrange[100],
              );
            },
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: defaultColor,)),
        );
      },
    );
  }
}
Widget buildChat(UserModel model,context)=>InkWell(
  onTap: (){
    navigateTo(context, ChatDetailsScreen(model: model,));
  },
  child:   Padding(
    padding: const EdgeInsets.all(25.0),

    child: Row(
      children: [
        CircleAvatar(
          radius: 27,
          backgroundImage: NetworkImage(
            model.image,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          model.name,
          style: Theme.of(context).textTheme.subtitle1,

        ),

      ],

    ),

  ),
);