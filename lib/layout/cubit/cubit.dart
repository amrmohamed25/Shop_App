import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favorite.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/category/category_screen.dart';
import 'package:shop_app/modules/favourites/favourite_screen.dart';
import 'package:shop_app/modules/product_screen/product_shop.dart';
import 'package:shop_app/modules/settings_screen/settings_shop.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_remote.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List screens = [
    ProductScreen(),
    CategoryScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];

  void setIndex(index) {
    currentIndex = index;
    emit(ShopChangeNavBarState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }

  Map<int, bool> favorites = {};
  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopFavoriteChangeState());
    DioHelper.postData(
            url: FAVOURITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (changeFavoriteModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoriteState(changeFavoriteModel!));
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavouriteState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorites() {
    emit(ShopGetFavoriteLoadingState());
    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavoriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouriteState());
    });
  }

  ShopLoginModel? userData;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopUpdateLoadingUserDataState());
    DioHelper.putData(url: UPDATE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateSuccessUserDataState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateErrorUserDataState());
    });
  }
}
