// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/modules/categories/categories_screen.dart';
import 'package:flutter_first_app/modules/cubit/shop_home_states.dart';
import 'package:flutter_first_app/modules/favorites/favorites_screen.dart';
import 'package:flutter_first_app/modules/products/products_screen.dart';
import 'package:flutter_first_app/modules/settings/settings.dart';
import 'package:flutter_first_app/shared/components/constants.dart';

import '../../models/shop_app/categories_model.dart';
import '../../models/shop_app/change_favorites_model.dart';
import '../../models/shop_app/favorites_model.dart';
import '../../models/shop_app/home_model.dart';
import '../../models/shop_app/login_model.dart';
import '../../shared/components/components.dart';
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

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(ShopHomeLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      emit(ShopHomeSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    emit(ShopHomeLoadingCategoriesState());

    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(value.data);

      emit(ShopHomeSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorCategoriesState());
    });
  }

  ChangeFavorites? changeFavoritesModel;

  void changeFavorites(int? productId) {
    if (favorites[productId] != null) {
      if (favorites[productId] == true) {
        favorites[productId] = false;
        emit(ShopHomeSuccessChangeFavoritesState());
      } else {
        favorites[productId] = true;
        emit(ShopHomeSuccessChangeFavoritesState());
      }
      emit(ShopHomeSuccessChangeFavoritesState());
    }

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavorites.fromJson(value.data);

      if (changeFavoritesModel!.status == false) {
        if (favorites[productId] == true) {
          favorites[productId] = false;
          showToast(
            message: changeFavoritesModel!.message ?? 'Something Error',
            state: ToastStates.ERROR,
          );
        } else {
          favorites[productId] = true;
          showToast(
            message: changeFavoritesModel!.message ?? 'Something Error',
            state: ToastStates.ERROR,
          );
        }
      } else {
        getFavorites();
      }

      emit(ShopHomeSuccessChangeFavoritesState());
    }).catchError((error) {
      emit(ShopHomeErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopHomeLoadingFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopHomeSuccessFavoritesState());
    }).catchError((error) {
      emit(ShopHomeErrorFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopHomeLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopHomeSuccessUserDataState(userModel));
    }).catchError((error) {
      emit(ShopHomeErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopHomeLoadingUserUpdateState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopHomeSuccessUserUpdateState(userModel));
    }).catchError((error) {
      emit(ShopHomeErrorUserUpdateState());
    });
  }
}
