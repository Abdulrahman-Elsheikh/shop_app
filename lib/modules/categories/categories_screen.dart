// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/categories_model.dart';
import '../cubit/shop_home_cubit.dart';
import '../cubit/shop_home_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, states) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => buildCatItem(
              ShopHomeCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount:
              ShopHomeCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image ?? ''),
              width: 100.0,
              height: 100.0,
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Text(
                model.name!.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
              iconSize: 20.0,
              onPressed: () {},
            ),
          ],
        ),
      );
}
