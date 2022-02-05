import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).model !=null,
          builder: (context)=> SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(8),
                  elevation: 2,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://t4.ftcdn.net/jpg/02/77/11/13/240_F_277111357_AEHr3yYNFCLPYGfsVVDsUARHkLjGnEfn.jpg',
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Communicate With Friend',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  itemBuilder:(context,index)=>homeBuild(SocialCubit.get(context).posts[index],context,index),
                  separatorBuilder: (context,index)=>SizedBox(
                    height: 3,
                  ),
                  scrollDirection:Axis.vertical ,
                  itemCount: SocialCubit.get(context).posts.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: defaultColor,)),
        );
      },
    );
  }
}
Widget homeBuild(PostModel postModel, context,index)=>Column(
  children: [
    Card(
      margin: EdgeInsets.all(8),
      elevation: 5,
     // color: HexColor('333739'),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    postModel.image,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          postModel.name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 12,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                        postModel.dateTime,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 10
                        )
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    icon: Icon(
                      IconBroken.More_Square,
                      color: Colors.deepOrange,
                    ),
                    onPressed: (){}
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: double.infinity,
              height: 1,
              padding: EdgeInsets.all(20),
              color: Colors.deepOrange[100],
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 1),
              child: Wrap(
                children: [
                  Text(
                    postModel.text,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                 /* Padding(
                    padding: const EdgeInsetsDirectional.only(end: 1.2),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                          height: 20,
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: (){},
                          child:Text(
                            '#SoftWare',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.blue,
                                fontSize: 12
                            ),
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 1.2),
                    child: Container(
                      height: 20,
                      child: MaterialButton(
                          height: 20,
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: (){},
                          child:Text(
                            '#Flutter',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.blue,
                                fontSize: 12
                            ),
                          )
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            if(postModel.postImage !='')
              Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                  image:NetworkImage(
                    postModel.postImage,
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400,

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 3),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 17,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption.copyWith(
                            // color: Colors.deepOrange[200],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Chat,
                          color: Colors.yellow,
                          size: 17,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${SocialCubit.get(context).comment[index]} Comment',
                          style: Theme.of(context).textTheme.caption.copyWith(
                            // color: Colors.deepOrange[200],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              padding: EdgeInsets.all(20),
              color: Colors.deepOrange[100],
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        SocialCubit.get(context).commentPost(SocialCubit.get(context).posId[index]);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(
                              SocialCubit.get(context).model.image,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Write a Comment...',
                            style: Theme.of(context).textTheme.caption.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      SocialCubit.get(context).likePost(SocialCubit.get(context).posId[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption.copyWith(
                              // color: Colors.deepOrange[200],
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);
