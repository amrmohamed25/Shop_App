import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return buildCategoryItem(
              ShopCubit.get(context).categoryModel!.data!.data[index]);
        },
        separatorBuilder: (BuildContext context, index) {
          return Container(
              width: double.infinity, height: 1, color: Colors.grey);
        },
        itemCount: ShopCubit.get(context).categoryModel!.data!.data.length);
  }

  Widget buildCategoryItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            child: Image(
              image: NetworkImage(model.image),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
