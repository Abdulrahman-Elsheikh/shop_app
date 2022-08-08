// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, deprecated_member_use, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/shared/bloc_observer.dart';
import 'package:flutter_first_app/shared/cubit/cubit.dart';
import 'package:flutter_first_app/shared/cubit/states.dart';
import 'package:flutter_first_app/shared/cubit/themes.dart';
import 'package:flutter_first_app/shared/network/local/cache_helper.dart';
// import 'layout/shop_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () {
      NewsCubit();
    },
    blocObserver: MyBlocObserver(),
  );

  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getModeBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          NewsCubit()..changeAppMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            // NewsCubit.get(context).isDark
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
            home: Directionality(
                textDirection: TextDirection.ltr, child: OnBoardingScreen()),
          );
        },
      ),
    );
  }
}
