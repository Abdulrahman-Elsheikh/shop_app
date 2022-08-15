// ignore_for_file: must_be_immutable, unused_local_variable, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/shop_app/search-model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../cubit/shop_home_cubit.dart';
import '../cubit/shop_search_cubit.dart';
import '../cubit/shop_search_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (BuildContext context, ShopSearchStates state) {},
        builder: (BuildContext context, ShopSearchStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultTextField(
                      width: double.infinity,
                      height: 50.0,
                      controller: searchController,
                      type: TextInputType.text,
                      onSubmit: (String text) =>
                          ShopSearchCubit.get(context).search(text),
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a search term';
                        }
                        return null;
                      },
                      hintText: 'Search',
                      labelText: 'Search',
                      prefixIcon: Icons.search,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            buildSearchItem(
                                ShopSearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data![index],
                                context),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: ShopSearchCubit.get(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(Product model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(model.image ?? ''),
              width: 120.0,
              height: 120.0,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
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
                  Spacer(),
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
      ),
    );
  }
}
