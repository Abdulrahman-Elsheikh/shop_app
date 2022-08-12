// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, deprecated_member_use, unnecessary_import, unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/layout/shop_layout.dart';
import 'package:flutter_first_app/modules/login/login_screen.dart';
import 'package:flutter_first_app/shared/bloc_observer.dart';
import 'package:flutter_first_app/shared/cubit/app_cubit.dart';
import 'package:flutter_first_app/shared/cubit/app_states.dart';
import 'package:flutter_first_app/shared/styles/themes.dart';
import 'package:flutter_first_app/shared/network/local/cache_helper.dart';
// import 'layout/shop_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () {
      AppCubit();
    },
    blocObserver: MyBlocObserver(),
  );

  DioHelper.init();
  await CacheHelper.init();

  bool isDark = await CacheHelper.getData(key: 'isDark') ?? false;
  Widget widget;
  bool onBoarding = await CacheHelper.getData(key: 'onBoarding') ?? false;
  String token = await CacheHelper.getData(key: 'token') ?? 'empty-token';

  if (onBoarding) {
    if (token != 'empty-token') {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(isDark: isDark, startWidget: widget));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({required this.isDark, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AppCubit()..changeAppMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
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
                textDirection: TextDirection.ltr, child: startWidget),
          );
        },
      ),
    );
  }
}
