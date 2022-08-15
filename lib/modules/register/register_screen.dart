// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../cubit/shop_register-states.dart';
import '../cubit/shop_register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status == true) {
              showToast(
                  message: state.loginModel.message ?? '',
                  state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token ?? 'empty-token';
                navigateAndEnd(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              showToast(
                  message: state.loginModel.message ?? '',
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'REGISTER',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: defaultColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Register now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          defaultTextField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your name';
                              }
                            },
                            labelText: 'Name',
                            prefixIcon: Icons.person_outline,
                            hintText: 'Name',
                          ),
                          const SizedBox(height: 30.0),
                          defaultTextField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              }
                            },
                            labelText: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                            hintText: 'Email Address',
                          ),
                          const SizedBox(height: 20.0),
                          defaultTextField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                            },
                            labelText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            hintText: 'Password',
                            suffixIcon:
                                ShopRegisterCubit.get(context).suffixIcon,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                          ),
                          const SizedBox(height: 30.0),
                          defaultTextField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                            },
                            labelText: 'Phone Number',
                            prefixIcon: Icons.phone_outlined,
                            hintText: 'Phone Number',
                          ),
                          const SizedBox(height: 30.0),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => defaultButton(
                              text: 'register',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ]),
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
