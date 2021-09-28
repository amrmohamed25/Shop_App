import 'package:shop_app/models/user_model.dart';

abstract class LoginShopStates {}

class LoginShopInitialState extends LoginShopStates {}

class LoginShopChangeVisibilityState extends LoginShopStates {}

class LoginShopLoadingState extends LoginShopStates {}

class LoginShopSuccessState extends LoginShopStates {
  final ShopLoginModel loginModel;

  LoginShopSuccessState(this.loginModel);
}

class LoginShopErrorState extends LoginShopStates {
  final String error;

  LoginShopErrorState({required this.error});
}
