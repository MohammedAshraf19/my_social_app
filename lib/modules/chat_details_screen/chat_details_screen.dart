import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel model;
  ChatDetailsScreen({
    this.model,
});
  var textController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(receiverId: model.uId);

        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: (){
                    navigatePop(context);
                  },
                  icon: Icon(
                    IconBroken.Arrow___Left_2,
                    color: defaultColor,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        model.image,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      model.name,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700

                      ),

                    ),

                  ],

                ),
              ),
              body: ConditionalBuilder(
                condition: true,//SocialCubit.get(context).messages.length>0,
                fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: defaultColor,)),
                builder: (context){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                              itemBuilder:(context,index){

                                var message = SocialCubit.get(context).messages[index];

                                if(SocialCubit.get(context).model.uId == message.senderId)
                                  return buildMyMessage(message);
                                return  buildMessage(message);
                  } ,
                              separatorBuilder:(context,index)=>SizedBox(height: 10,) ,
                              itemCount: SocialCubit.get(context).messages.length
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsetsDirectional.only(
                            start: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[200],
                                width: 1
                            ),
                            borderRadius:  BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'type message here',
                                    border: InputBorder.none,
                                  ),
                                  controller: textController,
                                ),
                              ),
                              Container(
                                height: 50,
                                color: defaultColor,
                                child: MaterialButton(
                                    child: Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    minWidth: 1,
                                    onPressed: (){
                                      SocialCubit.get(context).sendMessage(
                                        text: textController.text,
                                        dateTime: DateTime.now().toString(),
                                        receiverId: model.uId,
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
  Widget buildMessage(MessageModel messageModel)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Text(
        messageModel.text,
      ),
    ),
  );
  Widget buildMyMessage(MessageModel messageModel)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Text(
        messageModel.text,
      ),
    ),
  );
}
