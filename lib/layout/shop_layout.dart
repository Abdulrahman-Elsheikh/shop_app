// ignore_for_file: prefer_const_constructors, avoid_print, import_of_legacy_library_into_null_safe, invalid_required_positional_param, unused_local_variable, prefer_is_empty, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/cubit/shop_home_cubit.dart';
import '../modules/cubit/shop_home_states.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (BuildContext context, ShopHomeStates state) {},
      builder: (BuildContext context, ShopHomeStates state) {
        var cubit = ShopHomeCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('Shopify'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  }),
              //   IconButton(
              //       icon: Icon(Icons.brightness_4_outlined),
              //       onPressed: () {
              //         NewsCubit.get(context).changeAppMode();
              //       })
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          // ConditionalBuilder(
          //     condition: state is! NewsGetBusinessLoadingState,
          //     builder: (context) => cubit.screens[cubit.currentIndex],
          //     fallback: (context) =>
          //         Center(child: CircularProgressIndicator())),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.bottomNavigationBarItems,
          ),
        );
      },
    );
  }
}
