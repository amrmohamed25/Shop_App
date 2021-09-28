
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/network/remote/dio_remote.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'bloc_observer.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/boarding_screen/on_boarding.dart';
import 'modules/login/login_shop.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();

  Widget myWidget;
  bool? isDark = CacheHelper.getData('isDark') ?? false;
  bool? finishedBoarding = CacheHelper.getData('boarding') ?? false;
  token = CacheHelper.getData('token');

  if(finishedBoarding==true){
    if(token!=null){
      myWidget=ShopLayout();
    }
    else{
      myWidget=LoginShopScreen();
    }
  }else{
    myWidget=OnBoardingScreen();
  }
  runApp(MyApp(isDark, myWidget));
}

class MyApp extends StatelessWidget {
  bool? isDark;

  // bool? finishedBoarding;
  Widget myWidget;

  MyApp(this.isDark, this.myWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (BuildContext context) {
            return ShopCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getFavorites()
              ..getUserData();
          },

      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {

          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark == true ? ThemeMode.dark : ThemeMode.light,
              home:myWidget
          );
        },
    ));
  }
}
