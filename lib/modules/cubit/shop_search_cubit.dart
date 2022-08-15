import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/models/shop_app/search-model.dart';
import 'package:flutter_first_app/modules/cubit/shop_search_states.dart';
import 'package:flutter_first_app/shared/network/remote/dio_helper.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/endpoints.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(ShopSearchSuccessState());
    }).catchError((error) {
      emit(ShopSearchErrorState(error.toString()));
    });
  }
}
