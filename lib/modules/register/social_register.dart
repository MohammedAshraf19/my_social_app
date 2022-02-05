import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialRegister extends StatelessWidget {
  var emailController = TextEditingController();
  var userName = TextEditingController();
  var phone = TextEditingController();
  var formKey =GlobalKey<FormState>();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialCreateUserSuccess){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SocialLayout()));
          }
        },
        builder: (context,state)=>Scaffold(
          backgroundColor:  Colors.deepOrangeAccent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                navigatePop(context);
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.deepOrangeAccent,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60))
                      // borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Hallo,Register Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 462,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 60,start: 60,end:60),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'User Name',
                              prefixIcon: Icon(
                                IconBroken.User1,
                              ),
                            ),
                            controller: userName,
                            validator: (String value){
                              if(value.isEmpty)
                                return 'Name Must Not Be Null';
                              else
                                return null;
                            },
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email or Phone Number',
                              prefixIcon: Icon(
                                Icons.supervised_user_circle_rounded,
                              ),
                            ),
                            controller: emailController,
                            validator: (String value){
                              if(value.isEmpty)
                                return 'Email Must Not Be Null';
                              else
                                return null;
                            },
                            keyboardType: TextInputType.emailAddress,

                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    SocialRegisterCubit.get(context).suffixIcon,
                                    size: 20,
                                  ),
                                  onPressed: (){
                                    SocialRegisterCubit.get(context).showPasswordVisibility();
                                  }
                              ),
                              hintText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                            ),
                            controller: passwordController,
                            obscureText: SocialRegisterCubit.get(context).passwordVisibility,
                            validator: (String value){
                              if(value.isEmpty)
                                return 'Password Must Not Be Null';
                              else
                                return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              prefixIcon: Icon(
                                IconBroken.Call,
                              ),
                            ),
                            controller: phone,
                            validator: (String value){
                              if(value.isEmpty)
                                return 'Phone Must Not Be Null';
                              else
                                return null;
                            },
                            keyboardType: TextInputType.phone,

                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoading,
                          builder: (context)=> Container(
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                if(formKey.currentState.validate()){
                                  SocialRegisterCubit.get(context).userRegister(
                                      name: userName.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phone.text,
                                  );
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:   FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: defaultColor,)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
