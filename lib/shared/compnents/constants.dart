import 'package:social_app/modules/login/social_login.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'components.dart';

String uId ='';
//bool isDark ;
void SignOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      navigateAndFinish(context,SocialLogin());
    }
  });
}