// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, deprecated_member_use, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_first_app/shared/bloc_observer.dart';
import 'package:flutter_first_app/shared/cubit/cubit.dart';
import 'package:flutter_first_app/shared/cubit/states.dart';
import 'package:flutter_first_app/shared/network/local/cache_helper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/news_layout.dart';
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
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    titleSpacing: 20.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                )),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Directionality(
                textDirection: TextDirection.ltr, child: NewsLayout()),
          );
        },
      ),
    );
  }
}
