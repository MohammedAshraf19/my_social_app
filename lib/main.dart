import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/social_login.dart';
import 'package:social_app/modules/register/social_register.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/compnents/components.dart';
import 'package:social_app/shared/compnents/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(txt: 'on background message', state: ToastState.SUCCESS);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  var token =await FirebaseMessaging.instance.getToken();
 // print(token);

  //بيجيلى اشعار وانا فاتح التطبيق نفسه
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(txt: 'on message ', state: ToastState.SUCCESS);
  });
  // بيجيلى اشعار وانا فاتح التطبيق في خلفيه و ادوس عليها يفتح التطبيق
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(txt: 'on message opened app', state: ToastState.SUCCESS);
  });
  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  var isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  print(uId);
   uId = CacheHelper.getData(key: 'uId');
  if(uId != null)
    widget = SocialLayout();
  else
    widget =SocialLogin();
  runApp(MyApp(
    startWidget : widget,
    isDark: isDark,

  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget startWidget;
  final bool isDark;

   MyApp({
     this.startWidget,
     this.isDark,
   });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts()..changeDark(fromShared: isDark),
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state)=>MaterialApp(
          theme: lightTheme,
          home:startWidget,
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          themeMode:SocialCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
        ),
      ),
    );
  }
}
