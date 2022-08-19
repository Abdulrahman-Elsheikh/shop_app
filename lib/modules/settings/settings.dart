// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, invalid_required_positional_param, prefer_is_empty, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopify/shared/components/constants.dart';

import '../../shared/components/components.dart';
import '../cubit/shop_home_cubit.dart';
import '../cubit/shop_home_states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopHomeCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopHomeCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopHomeLoadingUserUpdateState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20),
                    defaultTextField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      hintText: 'Name',
                      labelText: 'Name',
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(height: 20),
                    defaultTextField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'email is required';
                        }
                        return null;
                      },
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 20),
                    defaultTextField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone is required';
                        }
                        return null;
                      },
                      hintText: 'Phone',
                      labelText: 'Phone',
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(height: 20),
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopHomeCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                    SizedBox(height: 20),
                    defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
