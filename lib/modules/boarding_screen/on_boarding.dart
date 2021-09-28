import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_shop.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String image;
  String title;
  String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List list = [
    BoardingModel("assets/images/market.png", "Screen Title1", "Screen Body1"),
    BoardingModel("assets/images/market.png", "Screen Title2", "Screen Body2"),
    BoardingModel("assets/images/market.png", "Screen Title3", "Screen Body3")
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              navigateAndReplace(context, LoginShopScreen());
              CacheHelper.setData(key: 'boarding', value: true);
            },
            child: Text(
              'SKIP',
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    itemCount: list.length,
                    controller: pageController,
                    onPageChanged: (index) {
                      if (index == list.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) {
                      return buildOnBoardItem(list[index]);
                    })),
            SizedBox(height: 20),
            Row(
              children: [
                SmoothPageIndicator(
                  count: list.length,
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    dotColor: Colors.grey,
                    spacing: 4.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      CacheHelper.setData(key: 'boarding', value: true);
                      navigateAndReplace(context, LoginShopScreen());
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('${model.image}'),
            ),
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
