import '../../models/shop_app/login_model.dart';

abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ShopHomeChangeBottomNavState extends ShopHomeStates {}

class ShopHomeLoadingHomeDataState extends ShopHomeStates {}

class ShopHomeSuccessHomeDataState extends ShopHomeStates {}

class ShopHomeErrorHomeDataState extends ShopHomeStates {}

class ShopHomeLoadingCategoriesState extends ShopHomeStates {}

class ShopHomeSuccessCategoriesState extends ShopHomeStates {}

class ShopHomeErrorCategoriesState extends ShopHomeStates {}

class ShopHomeSuccessChangeFavoritesState extends ShopHomeStates {}

class ShopHomeErrorChangeFavoritesState extends ShopHomeStates {}

class ShopHomeLoadingFavoritesState extends ShopHomeStates {}

class ShopHomeSuccessFavoritesState extends ShopHomeStates {}

class ShopHomeErrorFavoritesState extends ShopHomeStates {}

class ShopHomeLoadingUserDataState extends ShopHomeStates {}

class ShopHomeSuccessUserDataState extends ShopHomeStates {
  final ShopLoginModel? userModel;
  ShopHomeSuccessUserDataState(this.userModel);
}

class ShopHomeErrorUserDataState extends ShopHomeStates {}
