// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/shared/cubit/app_cubit.dart';
import 'package:flutter_first_app/shared/cubit/app_states.dart';

import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                  width: double.infinity,
                  height: 50.0,
                  controller: searchController,
                  type: TextInputType.text,
                  isPassword: false,
                  onSubmit: null,
                  onTap: null,
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
              // Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
