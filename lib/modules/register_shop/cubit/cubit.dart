import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/register_shop/cubit/register_states.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_remote.dart';

class RegisterCubit extends Cubit<RegisterShopStates> {
  RegisterCubit() : super(RegisterShopInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    emit(RegisterShopLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterShopSuccessState(loginModel!));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(RegisterShopErrorState(error: error.toString()));
    });
  }

  bool isHidden = true;
  IconData visibility = Icons.visibility;

  void changeVisibility() {
    isHidden = !isHidden;
    visibility = isHidden == true ? Icons.visibility : Icons.visibility_off;
    emit(RegisterShopChangeVisibilityState());
  }
}
