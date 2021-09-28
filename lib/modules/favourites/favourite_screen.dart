import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/models/favorite_model.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).favoriteModel != null
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return buildFavoriteItem(
                      ShopCubit.get(context).favoriteModel!.data.data[index],
                      context,
                      index);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  );
                },
                itemCount:
                    ShopCubit.get(context).favoriteModel!.data.data.length)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildFavoriteItem(DataModel model, context, index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.product.image,
                  ),
                  width: 100,
                  height: 100,
                ),
                if (model.product.discount != 0)
                  Container(
                      color: Colors.red,
                      child: const Text(
                        'Discount',
                        style: TextStyle(color: Colors.white),
                      )),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  child: Text(
                    model.product.name,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      model.product.price.toString(),
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (model.product.discount != 0)
                      Text(
                        model.product.oldPrice.toString(),
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    Material(
                      type: MaterialType.transparency,
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: IconButton(
                        // highlightColor: Colors.black,
                        icon: Icon(
                          ShopCubit.get(context).favorites[model.id] == false
                              // ShopCubit.get(context).homeModel!.data.products.firstWhere((element) => model.product.id==element.id).inFavorites==false
                              ? Icons.favorite_border
                              : Icons.favorite,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(model.product.id);
                        },
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
  }
}
