// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/categories_model.dart';
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
            condition: ShopHomeCubit.get(context).homeModel != null &&
                ShopHomeCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(
              ShopHomeCubit.get(context).homeModel,
              ShopHomeCubit.get(context).categoriesModel,
              context,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 10.0),
                      itemCount: categoriesModel!.data!.data.length,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: defaultColor,
                    ),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.65,
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    buildGridProduct(model.data!.products[index], context),
              ),
            ),
          ],
        ),
      );
}

Widget buildCategoryItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image(
          image: NetworkImage(model.image ?? ''),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          width: 100.0,
          height: 100.0,
          child: Center(
            child: Text(model.name!.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                )),
          ),
        ),
      ],
    );

Widget buildGridProduct(ProductModel model, context) => Container(
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
                      onPressed: () {
                        ShopHomeCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            ShopHomeCubit.get(context).favorites[model.id] !=
                                        null &&
                                    ShopHomeCubit.get(context)
                                            .favorites[model.id] ==
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
    );
