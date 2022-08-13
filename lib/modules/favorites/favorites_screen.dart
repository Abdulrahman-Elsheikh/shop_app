// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/favorites_model.dart';
import '../../shared/styles/colors.dart';
import '../cubit/shop_home_cubit.dart';
import '../cubit/shop_home_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, states) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopHomeLoadingFavoritesState,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => buildFavItem(
                ShopHomeCubit.get(context).favoritesModel!.data!.data![index],
                context),
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount:
                ShopHomeCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildFavItem(FavoriteProductsData model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product!.image ?? ''),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.fitHeight,
                ),
                if (model.product!.discount != 0)
                  Container(
                    color: defaultColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text('Discount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        )),
                  ),
              ],
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price.round() ?? 0}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          height: 1.25,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      if (model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice.round() ?? 0}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            height: 1.25,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopHomeCubit.get(context)
                              .changeFavorites(model.product!.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopHomeCubit.get(context)
                                          .favorites[model.product!.id] !=
                                      null &&
                                  ShopHomeCubit.get(context)
                                          .favorites[model.product!.id] ==
                                      true
                              ? defaultColor
                              : Colors.grey[300],
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 15.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
