// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/modules/categories/categories_screen.dart';
import 'package:flutter_first_app/modules/cubit/shop_home_states.dart';
import 'package:flutter_first_app/modules/favorites/favorites_screen.dart';
import 'package:flutter_first_app/modules/products/products_screen.dart';
import 'package:flutter_first_app/modules/settings/settings.dart';
import 'package:flutter_first_app/shared/components/constants.dart';

import '../../models/shop_app/home_model.dart';
import '../../shared/network/endpoints.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates> {
  ShopHomeCubit() : super(ShopHomeInitialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopHomeChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopHomeLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(value.data);
      print(homeModel!.status);

      emit(ShopHomeSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorHomeDataState());
    });
  }
}
