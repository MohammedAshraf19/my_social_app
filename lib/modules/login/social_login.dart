import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/register/social_register.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey =GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginError){
            showToast(txt: state.error, state: ToastState.ERROR);
          }
          if(state is SocialLoginSuccess){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              print(state.uId);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SocialLayout()));
            });
          }
        },
        builder: (context,state)=>Scaffold(
          backgroundColor:  Colors.deepOrangeAccent,
          appBar: AppBar(
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
                            'Login',
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
                            'Welcome Back',
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
                                      SocialLoginCubit.get(context).suffixIcon,
                                    size: 20,
                                  )

                                  , onPressed: (){
                                SocialLoginCubit.get(context).showPasswordVisibility();
                              }
                              ),
                              hintText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                            ),
                            controller: passwordController,
                            obscureText: SocialLoginCubit.get(context).passwordVisibility,
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
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is!SocialLoginLoading,
                          builder: (context)=>Container(
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                if(formKey.currentState.validate()){
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:   FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: defaultColor,)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have An Account? ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, SocialRegister());
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.deepOrange
                                ),
                              ),
                            ),
                          ],
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
