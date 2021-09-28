import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_remote.dart';

class LoginCubit extends Cubit<LoginShopStates> {
  LoginCubit() : super(LoginShopInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogIn({required String email, required String password}) {
    emit(LoginShopLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginShopSuccessState(loginModel!));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(LoginShopErrorState(error: error.toString()));
    });
  }

  bool isHidden = true;
  IconData visibility = Icons.visibility;

  void changeVisibility() {
    isHidden = !isHidden;
    visibility = isHidden == true ? Icons.visibility : Icons.visibility_off;
    emit(LoginShopChangeVisibilityState());
  }
}
