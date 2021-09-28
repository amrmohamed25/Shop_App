import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';

import 'cubit/cubit.dart';
import 'cubit/register_states.dart';

class RegisterShopScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return RegisterCubit();
      },
      child: BlocConsumer<RegisterCubit, RegisterShopStates>(
        listener: (context, state) {
          if (state is RegisterShopSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.setData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then(
                (value) {
                  token = state.loginModel.data!.token;
                  ShopCubit.get(context).currentIndex = 0;
                  ShopCubit.get(context).getHomeData();
                  ShopCubit.get(context).getCategoryData();
                  ShopCubit.get(context).getFavorites();
                  ShopCubit.get(context).getUserData();
                  navigateAndReplace(
                    context,
                    ShopLayout(),
                  );
                },
              );
            } else {
              buildToast(
                message: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
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
                          'Register',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register to view our various stocks',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        defaultFormField(
                            controller: nameController,
                            label: "Name",
                            keyType: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Name is too short';
                              }
                              return null;
                            },
                            prefix: Icons.person),
                        SizedBox(
                          height: 20,
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
                            isPassword: RegisterCubit.get(context).isHidden,
                            controller: passwordController,
                            onsubmit: (value) {
                              // RegisterCubit.get(context).userRegister(
                              //     name: nameController.text,
                              //     email: emailController.text,
                              //     password: passwordController.text,
                              //     phone: phoneController.text);
                            },
                            function: () {
                              RegisterCubit.get(context).changeVisibility();
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
                            suffix: RegisterCubit.get(context).visibility),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            label: "Phone",
                            keyType: TextInputType.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Phone is too short';
                              }
                              return null;
                            },
                            prefix: Icons.phone),
                        SizedBox(
                          height: 20,
                        ),
                        state is! RegisterShopLoadingState
                            ? defaultButton(
                                text: "REGISTER",
                                radius: 10,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
                                    // navigateAndReplace(context, HomeLayout());
                                  }
                                },
                              )
                            : Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
