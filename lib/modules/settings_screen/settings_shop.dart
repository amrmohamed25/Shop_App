import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (ShopCubit.get(context).userData != null) {
            nameController.text = ShopCubit.get(context).userData!.data!.name;
            emailController.text = ShopCubit.get(context).userData!.data!.email;
            phoneController.text = ShopCubit.get(context).userData!.data!.phone;
          }
          return ShopCubit.get(context).userData != null
              ? Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        if (state is ShopUpdateLoadingUserDataState)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            label: 'Name',
                            keyType: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an input to change your name or leave it as old name';
                              }
                              return null;
                            },
                            prefix: Icons.person),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: emailController,
                            label: 'Email',
                            keyType: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an input to change your email or leave it as old email';
                              }
                              return null;
                            },
                            prefix: Icons.mail),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            label: 'Phone',
                            keyType: TextInputType.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an input to change your phone or leave it as old phone';
                              }
                              return null;
                            },
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                          text: 'UPDATE',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                          text: 'Sign out',
                          function: () {
                            signOut(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
