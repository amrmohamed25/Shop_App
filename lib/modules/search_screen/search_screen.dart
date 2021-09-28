import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SearchCubit();
      },
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  defaultFormField(
                      controller: searchController,
                      label: 'Search',
                      keyType: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter something to search for';
                        }
                        return null;
                      },
                      prefix: Icons.search,
                      onchange: (value) {
                        SearchCubit.get(context).getSearch(value);
                      }),
                  SizedBox(height: 10),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(height: 10),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            ProductSearchModel model = SearchCubit.get(context)
                                .searchModel!
                                .data
                                .data[index];
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
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                            model.image,
                                          ),
                                          width: 100,
                                          height: 100,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Text(
                                            model.name,
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              model.price.toString(),
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Spacer(),
                                            Material(
                                              type: MaterialType.transparency,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: IconButton(
                                                // highlightColor: Colors.black,
                                                icon: Icon(
                                                  ShopCubit.get(context)
                                                                  .favorites[
                                                              model.id] ==
                                                          false
                                                      // ShopCubit.get(context).homeModel!.data.products.firstWhere((element) => model.product.id==element.id).inFavorites==false
                                                      ? Icons.favorite_border
                                                      : Icons.favorite,
                                                  color: Colors.blue,
                                                ),
                                                onPressed: () {
                                                  ShopCubit.get(context)
                                                      .changeFavorites(
                                                          model.id);
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
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey);
                          },
                          itemCount:
                              SearchCubit.get(context).searchModel != null
                                  ? SearchCubit.get(context)
                                      .searchModel!
                                      .data
                                      .data
                                      .length
                                  : 0),
                    )
                ],
              ),
            );
          }),
    );
  }
}
