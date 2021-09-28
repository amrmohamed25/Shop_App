import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register_shop/register_shop.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';

class LoginShopScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return LoginCubit();
      },
      child:
          BlocConsumer<LoginCubit, LoginShopStates>(listener: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);

        if (state is LoginShopSuccessState) {
          if (state.loginModel.status &&
              ShopCubit.get(context).userData != null) {
            CacheHelper.setData(
                    key: 'token',
                    value: LoginCubit.get(context).loginModel!.data!.token)
                .then((value) {
              token = state.loginModel.data!.token;
              ShopCubit.get(context).currentIndex = 0;
              ShopCubit.get(context).getHomeData();
              ShopCubit.get(context).getCategoryData();
              ShopCubit.get(context).getFavorites();
              ShopCubit.get(context).getUserData();
              buildToast(
                  message: cubit.loginModel!.message,
                  state: ToastStates.SUCCESS);
              navigateAndReplace(context, ShopLayout());
            });
          }
          if (state is LoginShopErrorState) {
            buildToast(
                message: cubit.loginModel!.message, state: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Login to view our various stocks',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      defaultFormField(
                          controller: emailController,
                          label: "Email",
                          keyType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Email is too short';
                            }
                            return null;
                          },
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          isPassword: LoginCubit.get(context).isHidden,
                          controller: passwordController,
                          onsubmit: (value) {
                            LoginCubit.get(context).userLogIn(
                                email: emailController.text,
                                password: passwordController.text);
                          },
                          function: () {
                            LoginCubit.get(context).changeVisibility();
                          },
                          label: "Password",
                          keyType: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          prefix: Icons.lock,
                          suffix: LoginCubit.get(context).visibility),
                      SizedBox(
                        height: 20,
                      ),
                      state is! LoginShopLoadingState
                          ? defaultButton(
                              text: "Login",
                              radius: 10,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogIn(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  // navigateAndReplace(context, HomeLayout());
                                }
                              },
                            )
                          : Center(child: CircularProgressIndicator()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an Account?'),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterShopScreen());
                            },
                            child: Text('Register Now'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
