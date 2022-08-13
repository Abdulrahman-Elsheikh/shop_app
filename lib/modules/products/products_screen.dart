// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/home_model.dart';
import '../../shared/styles/colors.dart';
import '../cubit/shop_home_cubit.dart';
import '../cubit/shop_home_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopHomeLoadingHomeDataState,
            builder: (context) =>
                productsBuilder(ShopHomeCubit.get(context).homeModel),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(HomeModel? model) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: model!.data!.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(height: 10.0),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.65,
              children: List.generate(
                model.data!.products.length,
                (index) => buildGridProduct(model.data!.products[index]),
              ),
            ),
          ],
        ),
      );
}

Widget buildGridProduct(ProductModel model) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image ?? ''),
                width: 200.0,
                height: 175.0,
                fit: BoxFit.fitHeight,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round() ?? 0}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round() ?? 0}',
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
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                      iconSize: 20.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
