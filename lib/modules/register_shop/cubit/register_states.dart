import 'package:shop_app/models/user_model.dart';

abstract class RegisterShopStates {}

class RegisterShopInitialState extends RegisterShopStates {}

class RegisterShopChangeVisibilityState extends RegisterShopStates {}

class RegisterShopLoadingState extends RegisterShopStates {}

class RegisterShopSuccessState extends RegisterShopStates {
  ShopLoginModel loginModel;

  RegisterShopSuccessState(this.loginModel);
}

class RegisterShopErrorState extends RegisterShopStates {
  final String error;

  RegisterShopErrorState({required this.error});
}
