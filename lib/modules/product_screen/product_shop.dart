import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/shop_states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoryModel != null)
            ? productsBuilder(ShopCubit.get(context).homeModel, context)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget productsBuilder(HomeModel? model, BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: model!.data.banners
                .map((e) => Image(
                      width: double.infinity,
                      image: NetworkImage('${e.image}'),
                      fit: BoxFit.fill,
                    ))
                .toList(),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCategoryItem(ShopCubit.get(context)
                          .categoryModel!
                          .data!
                          .data[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                    itemCount:
                        ShopCubit.get(context).categoryModel!.data!.data.length,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              childAspectRatio: 1 / 1.52,
              shrinkWrap: true,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(model.data.products.length, (index) {
                return buildGridProduct(model.data.products[index], context);
              }),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model, BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(
                  model.image,
                ),
                width: double.infinity,
                height: 180,
              ),
              if (model.discount != 0)
                Container(
                    color: Colors.red,
                    child: Text(
                      'Discount',
                      style: TextStyle(color: Colors.white),
                    )),
            ]),
            Container(
              height: 50,
              child: Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  model.price.round().toString(),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                if (model.discount != 0)
                  Text(
                    model.oldPrice.round().toString(),
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                Material(
                  type: MaterialType.transparency,
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: IconButton(
                    // highlightColor: Colors.black,
                    icon: Icon(
                      ShopCubit.get(context).favorites[model.id] == false
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryItem(DataModel dataModel) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(dataModel.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              dataModel.name,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
