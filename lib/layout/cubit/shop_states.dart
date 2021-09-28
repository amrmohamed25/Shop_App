import 'package:shop_app/models/change_favorite.dart';
import 'package:shop_app/models/user_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeNavBarState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoryDataState extends ShopStates {}

class ShopErrorCategoryDataState extends ShopStates {}

class ShopFavoriteChangeState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  ChangeFavoriteModel changeFavoriteModel;

  ShopSuccessChangeFavoriteState(this.changeFavoriteModel);
}

class ShopErrorChangeFavouriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavouriteState extends ShopStates {}

class ShopGetFavoriteLoadingState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  ShopLoginModel user;

  ShopSuccessUserDataState(this.user);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopUpdateLoadingUserDataState extends ShopStates {}

class ShopUpdateSuccessUserDataState extends ShopStates {
  ShopLoginModel user;

  ShopUpdateSuccessUserDataState(this.user);
}

class ShopUpdateErrorUserDataState extends ShopStates {}
