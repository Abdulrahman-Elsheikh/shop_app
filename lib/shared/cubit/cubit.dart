// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, avoid_function_literals_in_foreach_calls, invalid_required_positional_param

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/shared/cubit/states.dart';
import 'package:flutter_first_app/shared/network/local/cache_helper.dart';
// import 'package:sqflite/sqflite.dart';

import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/settings/settings.dart';
import '../../modules/sports/sports_screen.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  IconData fabIcon = Icons.add;

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball_outlined),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Business',
    'Science',
    'Sports',
    'Settings',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 1) getScienceNews();
    if (index == 2) getSportsNews();
    emit(NewsChangeBottomNavBarState());
  }

  void getBusinessNews() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '664ff3f563b148b8b3d7a50ae2945ec1',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getScienceNews() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '664ff3f563b148b8b3d7a50ae2945ec1',
      },
    ).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void getSportsNews() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '664ff3f563b148b8b3d7a50ae2945ec1',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'everything',
      query: {
        'q': value,
        'apiKey': '664ff3f563b148b8b3d7a50ae2945ec1',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putModeBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
