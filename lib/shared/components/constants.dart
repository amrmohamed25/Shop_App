import 'package:shop_app/modules/login/login_shop.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';

import 'components.dart';

void signOut(context) {
  CacheHelper.removeData('token').then((value) {
    navigateAndReplace(context, LoginShopScreen());
  });
}

String? token;

String? uId;
