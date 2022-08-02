// ignore_for_file: prefer_const_constructors, avoid_print, import_of_legacy_library_into_null_safe, invalid_required_positional_param, unused_local_variable, prefer_is_empty, use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/modules/search/search_screen.dart';
import 'package:flutter_first_app/shared/components/components.dart';
import 'package:flutter_first_app/shared/cubit/cubit.dart';
import 'package:flutter_first_app/shared/cubit/states.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_first_app/shared/components/components.dart';

// import '../shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessNews(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, NewsStates state) {},
        builder: (BuildContext context, NewsStates state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    }),
                IconButton(
                    icon: Icon(Icons.brightness_4_outlined),
                    onPressed: () {
                      NewsCubit.get(context).changeAppMode();
                    })
              ],
            ),
            body: ConditionalBuilder(
                condition: state is! NewsGetBusinessLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.changeIndex(index);
              },
              items: cubit.bottomNavigationBarItems,
            ),
          );
        },
      ),
    );
  }
}
