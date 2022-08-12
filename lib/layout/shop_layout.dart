// ignore_for_file: prefer_const_constructors, avoid_print, import_of_legacy_library_into_null_safe, invalid_required_positional_param, unused_local_variable, prefer_is_empty, use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/modules/login/login_screen.dart';
import 'package:flutter_first_app/modules/search/search_screen.dart';
import 'package:flutter_first_app/shared/components/components.dart';
import 'package:flutter_first_app/shared/cubit/app_cubit.dart';
import 'package:flutter_first_app/shared/cubit/app_states.dart';

import '../shared/network/local/cache_helper.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_first_app/shared/components/components.dart';

// import '../shared/network/remote/dio_helper.dart';

class ShopLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text('Shopify'),
              // actions: [
              //   IconButton(
              //       icon: Icon(Icons.search),
              //       onPressed: () {
              //         navigateTo(context, SearchScreen());
              //       }),
              //   IconButton(
              //       icon: Icon(Icons.brightness_4_outlined),
              //       onPressed: () {
              //         NewsCubit.get(context).changeAppMode();
              //       })
              // ],
            ),
            body: TextButton(
              child: Text('Sign Out'),
              onPressed: () {
                CacheHelper.removeData(key: 'token').then((value) {
                  navigateAndEnd(context, ShopLoginScreen());
                });
              },
            ),
            // ConditionalBuilder(
            //     condition: state is! NewsGetBusinessLoadingState,
            //     builder: (context) => cubit.screens[cubit.currentIndex],
            //     fallback: (context) =>
            //         Center(child: CircularProgressIndicator())),
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: cubit.currentIndex,
            //   onTap: (int index) {
            //     cubit.changeIndex(index);
            //   },
            //   items: cubit.bottomNavigationBarItems,
            // ),
          );
        },
      ),
    );
  }
}
